//
//  ToggleState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

@propertyWrapper
public struct OptionallyPersisted<Value: Sendable>: DynamicProperty {

  public enum Strategy {
    case external(Binding<Value>)
    case persisted(key: String, defaultValue: Value, store: UserDefaults = .standard)
    case transient(defaultValue: Value)
  }

  @State private var box: Box

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

extension OptionallyPersisted where Value == Bool {

  init<K: ToggleKey>(_ key: K.Type, store: UserDefaults = .standard) {
    self.init(.persisted(key: K.storageKey, defaultValue: K.defaultValue, store: store))
  }

  init(binding: Binding<Bool>) {
    self.init(.external(binding))
  }

  init(transient defaultValue: Bool = false) {
    self.init(.transient(defaultValue: defaultValue))
  }
}

extension OptionallyPersisted {
  // MARK: - Box

  //  @MainActor
  @Observable
  fileprivate final class Box {
    @ObservationIgnored private let strategy: Strategy

    var value: Value {
      didSet { writeIfNeeded(value) }
    }

    init(strategy: Strategy) {
      self.strategy = strategy
      self.value = Self.initialValue(for: strategy)
    }
  }
}

extension OptionallyPersisted.Box where Value == Bool {
  
  private static func initialValue(for strategy: OptionallyPersisted.Strategy) -> Value {
    switch strategy {
      case .external(let binding):
        return binding.wrappedValue
        
      case .persisted(let key, let defaultValue, let store):
        guard store.object(forKey: key) == nil else {
          return store.bool(forKey: key)
        }
        store.set(defaultValue, forKey: key)
        return defaultValue
        
      case .transient(let defaultValue):
        return defaultValue
    }
  }
}
extension OptionallyPersisted.Box {

  private func writeIfNeeded(_ newValue: Value) {
    switch strategy {
      case .external(let binding):
        binding.wrappedValue = newValue

      case .persisted(let key, _, let store):
        store.set(newValue, forKey: key)

      case .transient:
        break
    }
  }
}

//  private enum Storage: Sendable {
//    case external(Binding<Value>)
//    case persisted(key: String, defaultValue: Value)
//    case transient(defaultValue: Value)
//  }

//  private let storage: Strategy
//  @State private var transientValue: Value
//  @AppStorage private var persistedValue: Value
//
//  public var wrappedValue: Value {
//    get {
//      switch storage {
//        case .external(let binding):
//          return binding.wrappedValue
//        case .persisted:
//          return persistedValue
//        case .transient:
//          return transientValue
//      }
//    }
//    nonmutating set {
//      switch storage {
//        case .external(let binding):
//          binding.wrappedValue = newValue
//        case .persisted:
//          persistedValue = newValue
//        case .transient:
//          transientValue = newValue
//      }
//    }
//  }
//
//  public var projectedValue: Binding<Value> {
//    Binding(
//      get: { wrappedValue },
//      set: { wrappedValue = $0 }
//    )
//  }

//}

/// Type-safe toggle persistence
//  public init<K: ToggleKey>(_ keyType: K.Type) {
//    self.storage = .persisted(key: K.storageKey, defaultValue: K.defaultValue)
//    self._transientValue = State(initialValue: K.defaultValue)
//    self._persistedValue = AppStorage(wrappedValue: K.defaultValue, K.storageKey)
//  }
//
//  /// Keep external binding init
//  public init(binding: Binding<Value>) {
//    self.storage = .external(binding)
//    self._transientValue = State(initialValue: binding.wrappedValue)
//    self._persistedValue = AppStorage(wrappedValue: binding.wrappedValue, "unused")
//  }
//
//  /// Transient (non-persisted) storage
//  public init(transient defaultValue: Value) {
//    self.storage = .transient(defaultValue: defaultValue)
//    self._transientValue = State(initialValue: defaultValue)
//    self._persistedValue = AppStorage(wrappedValue: defaultValue, "unused")
//  }
//}
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
