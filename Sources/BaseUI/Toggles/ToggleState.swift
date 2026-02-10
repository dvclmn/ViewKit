//
//  ToggleState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

//struct ConditionalStorage<Value> {
//  private let external: Binding<Value>?
//  private let getInternal: () -> Value
//  private let setInternal: (Value) -> Void
//  
//  var binding: Binding<Value> {
//    external ?? Binding(get: getInternal, set: setInternal)
//  }
//  
//  static func make(
//    external: Binding<Value>?,
//    transient: Binding<Value>,
//    persisted: Binding<Value>,
//    usesPersistence: Bool
//  ) -> ConditionalStorage {
//    ConditionalStorage(
//      external: external,
//      getInternal: { usesPersistence ? persisted.wrappedValue : transient.wrappedValue },
//      setInternal: { usesPersistence ? (persisted.wrappedValue = $0) : (transient.wrappedValue = $0) }
//    )
//  }
//}

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

  /// External binding
  public init(binding: Binding<Value>) {
//    print("Initialised with a binding. \(binding)")
    self.storage = .external(binding)

    /// Dummy initializations - these won't be used
    self._transientValue = State(initialValue: binding.wrappedValue)
    self._persistedValue = AppStorage(wrappedValue: binding.wrappedValue, "unused")
  }

  /// Optional persistence
  public init(defaultValue: Value, persistenceKey: String? = nil) {
    if let key = persistenceKey {
      self.storage = .persisted(key: key, defaultValue: defaultValue)
    } else {
//      print("No persistence key provided, using default value instead.")
      self.storage = .transient(defaultValue: defaultValue)
    }
    self._transientValue = State(initialValue: defaultValue)
    self._persistedValue = AppStorage(wrappedValue: defaultValue, persistenceKey ?? "unused")
  }
}

// MARK: - Alternative approach

//@Observable
//private final class ToggleState {
//  enum Source {
//    case external(Binding<Bool>)
//    case appStorage(AppStorage<Bool>)
//    case state(Published<Bool>)
//  }
//
//  let source: Source
//
//  var binding: Binding<Bool> {
//    switch source {
//      case .external(let binding):
//        return binding
//        
//      case .appStorage(let storage):
//        return storage.projectedValue
//        
//      case .state(let published):
//        return Binding(
//          get: { published.wrappedValue },
//          set: { published.wrappedValue = $0 }
//        )
//    }
//  }
//
//  init(binding: Binding<Bool>) {
//    self.source = .external(binding)
//  }
//
//  init(defaultValue: Bool, persistenceKey: String?) {
//    if let key = persistenceKey {
//      self.source = .appStorage(AppStorage(wrappedValue: defaultValue, key))
//    } else {
//      self.source = .state(Published(wrappedValue: defaultValue))
//    }
//  }
//}
