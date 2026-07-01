//
//  UserDataHandler.swift
//  ViewKit
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI
@_spi(Internal) import CoreTools

/// Core contract for types that manage editable user data with a readiness
/// lifecycle.
///
/// The handler deliberately separates the working value from the backing value:
/// `dataState` owns the value currently being edited by the UI, while `storage`
/// is the value used to hydrate and persist that working copy.
@MainActor
public protocol UserDataHandler: Observation.Observable, AnyObject {
  associatedtype Value: Equatable

  /// Tracks readiness and holds the editable in-memory value when ready.
  ///
  /// Prefer thinking of this as the handler's working user data state rather
  /// than as a load-status flag. Mutations update this value first; persistence
  /// to `storage` happens explicitly through `userDataDidChange`.
  var dataState: UserDataState<Value> { get set }

  /// Backing value used for hydration and persistence.
  ///
  /// `UserDataView` copies this value into ``dataState`` when the handler first
  /// becomes ready, then writes ready-value changes back through
  /// `userDataDidChange`. It is not the live editing value while the handler is
  /// ready.
  var storage: Value { get set }

  /// Optional undo manager used to register undo/redo for data mutations.
  /// Provide a weak reference from hosting contexts that support undo.
  var undoManager: UndoManager? { get set }

  /// Debounces outbound syncs to backing storage to avoid excessive writes.
  var debouncer: AsyncDebouncer { get }
  
  init(state: UserDataState<Value>)
}

// MARK: - Core storage sync
extension UserDataHandler {

  /// Marks the handler as ready with the provided editable value.
  ///
  /// This does not update ``storage``. It establishes the in-memory working
  /// value that views and bindings should read from.
  public func setReady(_ value: Value) {
//    print("Set \(Self.self) to status of `UserDataState.ready` at \(Date.debug)")
    dataState = .ready(value)
  }

  /// Convenience flag indicating whether the handler has a ready value.
  public var isReady: Bool { dataState.isReady }

  /// Core mutation pipeline for the editable in-memory value.
  ///
  /// Applies the change, publishes the new ready value, and optionally registers
  /// undo. Persistence remains a separate step handled by
  /// ``userDataDidChange(_:updateStorage:)``.
  @MainActor
  package func updateData(
    _ action: UpdateKind = .standard,
    file: StaticString = #fileID,
    line: UInt = #line,
    perform change: (inout Value) -> Void,
  ) {
    /// Read user data (precondition: must be `.ready`).
    var current = unsafeReadyData(file: file, line: line)

    /// Capture for undo
    let old = current

    /// Mutate data in place
    change(&current)

    /// Publish the new working value.
    dataState = .ready(current)

    /// Handle undo
    if case .withUndo(let actionName) = action {
      if undoManager == nil {
        print("⚠️ Attempted to register undo without providing an undoManager to `\(Self.Type.self)`")
      }
      undoManager?.registerUndo(withTarget: self) { target in
        target.updateData(action) { $0 = old }
      }
      if let actionName { undoManager?.setActionName(actionName) }
    }
  }

  /// Debounced hook to sync the ready value to backing storage.
  /// Skips if no ready value is present.
  @MainActor
  package func userDataDidChange(
    _ isDebugging: Bool = false,
    updateStorage: @escaping (Value) -> Void,
  ) {
    /// Ensure we have a value to persist.
    guard let data = userDataIfPresent else {
      print("No local in-memory data found, nothing to save. \(Date.debug)")
      return
    }
    /// Coalesce rapid changes before writing to storage.
    debouncer.execute { @MainActor in
      updateStorage(data)
    }
  }
}
