//
//  UserDataHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI


/// Core contract for types that manage an in-memory user data value with a readiness lifecycle.
/// Provides state, storage, and coordination for updates and persistence.
@MainActor
public protocol UserDataHandler: Observation.Observable, AnyObject {
  associatedtype Value: Equatable

  /// Tracks whether the in-memory value is loading or `.ready`, and holds the current value when ready.
  var dataState: LoadState<Value> { get set }

  /// Backing storage for persistence or disk sync. Keep in sync via `userDataDidChange`.
  var storage: Value { get set }

  /// Optional undo manager used to register undo/redo for data mutations.
  /// Provide a weak reference from hosting contexts that support undo.
  var undoManager: UndoManager? { get set }

  /// Debounces outbound syncs to backing storage to avoid excessive writes.
  var debouncer: AsyncDebouncer { get }
  
  init(data: LoadState<Value>)
}

// MARK: - Core storage sync
extension UserDataHandler {

  /// Marks the handler as `.ready` with the provided value.
  /// Use after loading or hydrating initial data.
  public func setReady(_ value: Value) {
    print("Set \(Self.self) to status of `LoadState.ready` at \(Date.debug)")
    dataState = .ready(value)
  }

  /// Convenience flag indicating whether the handler has a ready value.
  public var isReady: Bool { dataState.isReady }

  /// Core mutation pipeline for the in-memory value.
  /// Applies the change, updates `dataState`, and optionally registers undo.
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

    /// Publish the new value.
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

  /// Debounced hook to sync the in-memory value to backing storage.
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
