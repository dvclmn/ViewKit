//
//  ToggleState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

@propertyWrapper
public struct OptionallyPersisted<Value: Sendable>: Sendable, DynamicProperty {
  private enum Storage: Sendable {
    case external(Binding<Value>)
    case persisted(key: String, defaultValue: Value)
    case transient(defaultValue: Value)
  }

  private let storage: Storage
  @State private var transientValue: Value
  @AppStorage private var persistedValue: Value

  public var wrappedValue: Value {
    get {
      switch storage {
        case .external(let binding):
          return binding.wrappedValue
        case .persisted:
          return persistedValue
        case .transient:
          return transientValue
      }
    }
    nonmutating set {
      switch storage {
        case .external(let binding):
          binding.wrappedValue = newValue
        case .persisted:
          persistedValue = newValue
        case .transient:
          transientValue = newValue
      }
    }
  }

  public var projectedValue: Binding<Value> {
    Binding(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }

}

extension OptionallyPersisted where Value == Bool {

  /// Type-safe toggle persistence
  public init<K: ToggleKey>(_ keyType: K.Type) {
    self.storage = .persisted(key: K.storageKey, defaultValue: K.defaultValue)
    self._transientValue = State(initialValue: K.defaultValue)
    self._persistedValue = AppStorage(wrappedValue: K.defaultValue, K.storageKey)
  }

  /// Keep external binding init
  public init(binding: Binding<Value>) {
    self.storage = .external(binding)
    self._transientValue = State(initialValue: binding.wrappedValue)
    self._persistedValue = AppStorage(wrappedValue: binding.wrappedValue, "unused")
  }

  /// Transient (non-persisted) storage
  public init(transient defaultValue: Value) {
    self.storage = .transient(defaultValue: defaultValue)
    self._transientValue = State(initialValue: defaultValue)
    self._persistedValue = AppStorage(wrappedValue: defaultValue, "unused")
  }
}
//extension OptionallyPersisted where Value == Bool {
//
//  /// External binding
//  public init(binding: Binding<Value>) {
//    self.storage = .external(binding)
//
//    /// Dummy initializations - these won't be used
//    self._transientValue = State(initialValue: binding.wrappedValue)
//    self._persistedValue = AppStorage(wrappedValue: binding.wrappedValue, "unused")
//  }
//
//  /// Optional persistence
//  public init(defaultValue: Value, persistenceKey: String? = nil) {
//    if let key = persistenceKey {
//      self.storage = .persisted(key: key, defaultValue: defaultValue)
//    } else {
//      self.storage = .transient(defaultValue: defaultValue)
//    }
//    self._transientValue = State(initialValue: defaultValue)
//    self._persistedValue = AppStorage(wrappedValue: defaultValue, persistenceKey ?? "unused")
//  }
//}
