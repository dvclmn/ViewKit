//
//  UserDataHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

@MainActor
public protocol UserDataHandler: Observation.Observable, AnyObject {
  associatedtype Value: Equatable

  var dataState: LoadState<Value> { get set }
  var storage: Value { get set }

  /// Make this a `weak var`
  var undoManager: UndoManager? { get set }
  var debouncer: AsyncDebouncer { get }
}

// MARK: - Core storage sync
extension UserDataHandler {

  /// Handles core setting of data, as well as undo/redo behaviour
  @MainActor
  package func updateData(
    _ action: UpdateKind = .standard,
    perform change: (inout Value) -> Void
  ) {
    /// Read user data
    var current = requireData()
    /// Capture for undo
    let old = current

    /// Mutate data
    change(&current)

    /// Write to local state
    dataState = .ready(current)

    /// Handle undo
    if case .withUndo(let actionName) = action {
      if undoManager == nil {
        print("⚠️ Attempted to register undo without providing an undoManager to `\(Self.Type.self)`")
      }
      undoManager?.registerUndo(withTarget: self) { target in
        target.updateData(.standard) { $0 = old }
      }
      if let actionName { undoManager?.setActionName(actionName) }
    }
  }

  @MainActor
  public func userDataDidChange(
    _ isDebugging: Bool = false,
    updateStorage: @escaping (Value) -> Void,
  ) {
    guard let data = userDataIfPresent else {
      print("No local in-memory data found, nothing to save. \(Date.debug)")
      return
    }
    debouncer.execute { @MainActor in
      updateStorage(data)
    }
  }
}
