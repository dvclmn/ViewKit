//
//  ToggleState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

@propertyWrapper
public struct OptionallyPersisted<Value: Sendable>: DynamicProperty {

  /// 1. We redefine Strategy to hold a 'Bridge' for the persisted case.
  /// This bridge contains the logic for reading/writing specific types.
  public enum Strategy {
    case external(Binding<Value>)
    case persisted(key: String, defaultValue: Value, store: UserDefaults, bridge: PersistenceBridge<Value>)
    case transient(defaultValue: Value)
  }

  @State private var box: Box

  /// 2. The main init is now fully generic.
  /// It doesn't care if Value is Bool, Int, or a complex Struct.
  public init(_ strategy: Strategy) {
    _box = State(initialValue: Box(strategy: strategy))
  }

  public var wrappedValue: Value {
    get { box.value }
    nonmutating set { box.value = newValue }
  }

  @MainActor
  public var projectedValue: Binding<Value> {
    Binding(get: { wrappedValue }, set: { wrappedValue = $0 })
  }
}

// MARK: - The Generic Boundary (Helper)
/// This simple struct carries the type-specific logic.
public struct PersistenceBridge<Value: Sendable>: Sendable {
  let read: @Sendable (UserDefaults, String) -> Value?
  let write: @Sendable (UserDefaults, String, Value) -> Void
}

// MARK: - The "Bool" Boundary
/// All special case logic lives exclusively in these extensions.

extension OptionallyPersisted.Strategy where Value == Bool {

  /// This static factory method allows the user to type `.persisted(...)`
  /// without manually constructing the bridge.
  public static func persisted(
    key: String,
    defaultValue: Value,
    store: UserDefaults = .standard,
  ) -> Self {
    .persisted(
      key: key,
      defaultValue: defaultValue,
      store: store,
      bridge: .bool,  // Inject the Bool specific logic here
    )
  }
}

/// Define the specific read/write logic for Bool
extension PersistenceBridge where Value == Bool {
  static var bool: Self {
    PersistenceBridge(
      read: { store, key in
        /// UserDefaults returns nil if key doesn't exist, generic object otherwise.
        /// We explicitly check generic object existence to differentiate "false" from "not found"
        guard store.object(forKey: key) != nil else { return nil }
        return store.bool(forKey: key)
      },
      write: { store, key, value in
        store.set(value, forKey: key)
      },
    )
  }
}

// MARK: - Convenience Initializers
extension OptionallyPersisted where Value == Bool {

  public init<K: ToggleKey>(_ key: K.Type, store: UserDefaults = .standard) {
    self.init(.persisted(key: K.storageKey, defaultValue: K.defaultValue, store: store))
  }

  public init(binding: Binding<Bool>) {
    self.init(.external(binding))
  }

  public init(transient defaultValue: Bool = false) {
    self.init(.transient(defaultValue: defaultValue))
  }
}
