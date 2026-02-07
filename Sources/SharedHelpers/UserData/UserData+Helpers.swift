//
//  UserData+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

// MARK: - Reading Data
extension UserDataHandler {

  /// Ready-only accessor. Use this only inside views that are presented after gating on `.ready`.
  @MainActor
  public var userData: Value { unsafeReadyData() }

  /// Useful in cases where I do want to check for a present value
  public var userDataIfPresent: Value? { dataState.readyValue }

  /// Returns the current data when the handler is `.ready`.
  /// Triggers a precondition failure if called before readiness.
  package func unsafeReadyData(
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> Value {
    guard let data = dataState.readyValue else {
      preconditionFailure(
        "\(String(describing: Value.self)) accessed before `LoadState` ready",
        file: file,
        line: line
      )
    }
    return data
  }

}

// MARK: - Setting Data
extension UserDataHandler {

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
}

// MARK: - Binding Data
extension UserDataHandler {

  /// Binding to a non-optional wave (use only in ready path)
  @MainActor
  public func dataBinding(_ action: UpdateKind = .standard) -> Binding<Value> {
    Binding(
      get: { self.unsafeReadyData() },
      set: { newValue in
        self.updateData(action) { $0 = newValue }
      }
    )
  }
}
