//
//  ToggleInitConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import SwiftUI

public struct ToggleConfiguration {
  public let title: String
  public let strategy: OptionallyPersisted<Bool>.Strategy

  public init<K: ToggleKey>(_ key: K.Type) {
    self.title = K.displayName
    self.strategy = .persisted(key: K.storageKey, defaultValue: K.defaultValue)
  }

  public init(_ title: String, binding: Binding<Bool>) {
    self.title = title
    self.strategy = .external(binding)
  }

  public init(_ title: String, transient defaultValue: Bool = false) {
    self.title = title
    self.strategy = .transient(defaultValue: defaultValue)
  }
}

extension ToggleConfiguration {

  /// Creates the actual Property Wrapper instance from this configuration.
  /// This is what allows us to assign to `_isExpanded` in your Views.
  public var asPropertyWrapper: OptionallyPersisted<Bool> {
    OptionallyPersisted(strategy)
  }
}
