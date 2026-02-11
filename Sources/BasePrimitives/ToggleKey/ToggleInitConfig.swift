//
//  ToggleInitConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import SwiftUI

/// Encapsulates the initialization strategy for toggle-based views
public struct ToggleConfiguration {
  public let title: String
  public let persistedValue: OptionallyPersisted<Bool>
  
  /// Key-based
  public init<K: ToggleKey>(_ key: K.Type) {
    self.title = K.displayName
    self.persistedValue = OptionallyPersisted(key)
  }
  
  /// Binding-based
  public init(_ title: String, binding: Binding<Bool>) {
    self.title = title
    self.persistedValue = OptionallyPersisted(binding: binding)
  }
  
  /// Transient
  public init(_ title: String, transient defaultValue: Bool = true) {
    self.title = title
    self.persistedValue = OptionallyPersisted(transient: defaultValue)
  }
}
