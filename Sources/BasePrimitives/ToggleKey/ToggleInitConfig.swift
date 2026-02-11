//
//  ToggleInitConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

/// Encapsulates the initialization strategy for toggle-based views
public struct ToggleConfiguration {
  let title: String
  let persistedValue: OptionallyPersisted<Bool>
  
  // Key-based
  public init<K: ToggleKey>(_ key: K.Type) {
    self.title = K.displayName
    self.persistedValue = OptionallyPersisted(key)
  }
  
  // Binding-based
  public init(_ title: String, binding: Binding<Bool>) {
    self.title = title
    self.persistedValue = OptionallyPersisted(binding: binding)
  }
  
  // Transient
  public init(_ title: String, transient defaultValue: Bool = true) {
    self.title = title
    self.persistedValue = OptionallyPersisted(transient: defaultValue)
  }
  
  // Legacy string-based (deprecated)
  @available(*, deprecated, message: "Use init(_:) with a ToggleKey type instead")
  public init(_ title: String, persistenceKey: String?, defaultValue: Bool = true) {
    self.title = title
    if let key = persistenceKey {
      self.persistedValue = OptionallyPersisted(
        defaultValue: defaultValue,
        persistenceKey: key
      )
    } else {
      self.persistedValue = OptionallyPersisted(transient: defaultValue)
    }
  }
}
