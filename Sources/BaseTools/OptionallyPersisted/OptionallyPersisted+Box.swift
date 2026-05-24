//
//  OptionallyPersisted+Box.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/4/2026.
//

import SwiftUI

// MARK: - Logic (The Box)
extension OptionallyPersisted {

  @Observable
  package final class Box {
    @ObservationIgnored private let strategy: Strategy

    var value: Value {
      didSet { save(value) }
    }

    /// 3. The Init is generic. Logic is derived strictly from the Strategy enum.
    init(strategy: Strategy) {
      self.strategy = strategy

      switch strategy {
        case .external(let binding):
          self.value = binding.wrappedValue

        case .transient(let defaultValue):
          self.value = defaultValue

        case .persisted(let key, let defaultValue, let store, let bridge):

          /// The Box asks the Bridge: "Do you have a value? If not, use default."
          if let persistedValue = bridge.read(store, key) {
            self.value = persistedValue

          } else {
            /// Determine if we should write the default value immediately on first load
            /// Optional, depending on preference
            store.setValue(defaultValue, forKey: key)
            self.value = defaultValue
          }
      }
    }

    /// 4. Write logic is also generic.
    private func save(_ newValue: Value) {
      switch strategy {
        case .external(let binding):
          binding.wrappedValue = newValue

        case .transient:
          break  // Do nothing

        case .persisted(let key, _, let store, let bridge):
          bridge.write(store, key, newValue)
      }
    }
  }
}
