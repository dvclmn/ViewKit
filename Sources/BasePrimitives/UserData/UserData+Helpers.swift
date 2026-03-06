//
//  UserData+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CasePaths
import SwiftUI

// MARK: - Reading Data
extension UserDataHandler {

  /// Non-optional accessor for in-memory user data once `.ready`.
  /// Crashes via precondition if accessed before readiness. Prefer this inside views gated on `.ready`.
  @MainActor
  public func userData(
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> Value {
    unsafeReadyData(file: file, line: line)
  }

  /// Optional accessor to inspect the current in-memory value, if initialized.
  /// Returns `nil` before the handler reaches `.ready`.
  public var userDataIfPresent: Value? { dataState.readyValue }

  /// Returns the current data when the handler is `.ready`.
  /// Triggers a precondition failure if called before readiness.
  /// Backing for the non-optional `userData` accessor.
  package func unsafeReadyData(
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> Value {
    guard let data = dataState.readyValue else {
      preconditionFailure(
        "\(String(describing: Value.self)) accessed before `LoadState` ready. File: \(file), Line: \(line)",
        file: file,
        line: line
      )
    }
    return data
  }
}

// MARK: - Setting Data
extension UserDataHandler {

  /// Mutates a single property on the in-memory value and propagates updates.
  /// Convenience for targeted updates without rewriting the whole `Value`.
  @MainActor
  public func setValue<T>(
    action: UpdateKind = .standard,
    _ keyPath: WritableKeyPath<Value, T>?,
    to value: T,
    file: StaticString = #fileID,
    line: UInt = #line
  ) {
    guard let keyPath else { return }
    updateData(action, file: file, line: line) { $0[keyPath: keyPath] = value }
  }

  /// Performs an in-place mutation of the in-memory value.
  /// Supports undo registration via `UpdateKind`.
  @MainActor
  public func setValue(
    action: UpdateKind = .standard,
    perform change: (inout Value) -> Void,
    file: StaticString = #fileID,
    line: UInt = #line
  ) {
    updateData(action, file: file, line: line, perform: change)
  }

}

// MARK: - Binding Data
extension UserDataHandler {

  /// Binding to the non-optional in-memory value (use only when `.ready`).
  /// Writes propagate through `updateData`, optionally registering undo.
  @MainActor
  public func dataBinding(
    _ action: UpdateKind = .standard,
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> Binding<Value> {
    Binding(
      get: { self.unsafeReadyData(file: file, line: line) },
      set: { newValue in
        self.updateData(action, file: file, line: line) { $0 = newValue }
      }
    )
  }
}
