//
//  UserData+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

extension UserDataHandler {

  public func setReady(_ value: Value) {
    dataState = .ready(value)
  }
  public var isReady: Bool { dataState.isReady }

  /// Useful in cases where I do want to check for a present value
  public var userDataIfPresent: Value? { dataState.readyValue }

  // MARK: - Reading Data
  /// Ready-only accessor. Use this only inside views that are presented after gating on `.ready`.
  @MainActor
  public var userData: Value { requireData() }

  /// Crashes early if misused outside `.ready`.
  /// Backing for the non-optional API
  package func requireData(
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

  // MARK: - Setting Data
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

  // MARK: - Binding Data
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

}
