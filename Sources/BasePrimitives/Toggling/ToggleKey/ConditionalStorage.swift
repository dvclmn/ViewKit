//
//  ConditionalStorage.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

// MARK: - Alternative approach to OptionallyPersisted

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
