//
//  LoadingState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public enum LoadState<Value> {
  case idle  // not started yet
  case loading  // in-flight
  case failed(Error)  // failed to load
  case ready(Value)  // hydrated and ready
}

@MainActor
public protocol UserDataHandler: Observation.Observable, AnyObject {
  associatedtype Value

  var dataState: LoadState<Value> { get set }
  //  var storage: Value { get set }

  //  var locker: any ValueLocker<Value> { get }

  /// Make this a `weak var`
  var undoManager: UndoManager? { get set }
  var debouncer: AsyncDebouncer { get }
}

extension UserDataHandler {

  /// Ready-only accessor. Use this only inside views that are presented after gating on `.ready`.
  @MainActor
  public var userData: Value {
    get { requireData() }
    set { setValue { $0 = newValue } }
  }

  /// If you still want an optional for convenience in a few places:
  public var userDataIfPresent: Value? {
    if case .ready(let data) = dataState { return data }
    return nil
  }

  public var isReady: Bool {
    if case .ready = dataState { return true }
    return false
  }

  public func setReady(_ value: Value) {
    dataState = .ready(value)
  }

  /// Crashes early if misused outside `.ready`. Keeps the non-optional API honest.
  private func requireData(
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> Value {
    guard case .ready(let data) = dataState else {
      preconditionFailure(
        "\(String(describing: Value.self)) accessed before ready",
        file: file,
        line: line
      )
    }
    return data
  }

  @MainActor
  public func setValue<T>(_ keyPath: WritableKeyPath<Value, T>, to value: T) {
    updateData { $0[keyPath: keyPath] = value }
  }

  @MainActor
  public func setValue(
    action: UpdateKind = .standard,
    perform change: (inout Value) -> Void
  ) {
    updateData(action, perform: change)
  }

  /// Binding to a non-optional wave (use only in ready path)
  @MainActor
  public func dataBinding(_ action: UpdateKind = .standard) -> Binding<Value> {
    Binding(
      get: { self.requireData() },
      set: { newValue in
        self.updateData(action) { $0 = newValue }
      }
    )
  }

  @MainActor
  private func updateData(
    _ action: UpdateKind = .standard,
    perform change: (inout Value) -> Void
  ) {
    /// Read user data
    guard case .ready(var current) = dataState else {
      assertionFailure("`updateData` called before `LoadState` ready")
      return
    }

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
    //  ) -> Value {
    //    guard let data = userDataIfPresent else {
    //      if isDebugging {
    //        print("No local in-memory data found, nothing to save. \(Date.debug)")
    //      }
    //
    //    }

    debouncer.execute { @MainActor in
      updateStorage(self.requireData())
      //      updateStorage(&data)
      //      updateStorage { storage in
      ////      self.locker.withLock { storage in
      //        if isDebugging {
      //          print("Saving now. \(Date.debug)")
      //          print("Diff: \(diff(storage, data))\n\n")
      //        }
      //        storage = data
      //      }
    }
  }

  //  @MainActor
  //  func userDataDidChange(
  //    _ isDebugging: Bool = false,
  //    updateWithLock: (inout Value) -> Void,
  //  ) {
  //    guard let data = userDataIfPresent else {
  //      if isDebugging {
  //        print("No local in-memory data found, nothing to save to storage. \(Date.debug)")
  //      }
  //      return
  //    }
  //    debouncer.execute { @MainActor in
  //      updateWithLock {
  //        if isDebugging {
  //          print("Saving stage config now. \(Date.debug)")
  //          print("Diff: \(diff($0, data))\n\n")
  //        }
  //        $0 = data
  //      }
  //      //      self.$storage.withLock {
  //      //        if isDebugging {
  //      //          print("Saving stage config now. \(Date.debug)")
  //      //          print("Diff: \(diff($0, data))\n\n")
  //      //        }
  //      //        $0 = data
  //      //      }
  //    }
  //  }
}
