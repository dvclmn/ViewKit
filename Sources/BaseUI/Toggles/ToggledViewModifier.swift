//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import BasePrimitives
import SwiftUI

/// Type-safe with derived title from key
/// ```
/// ShaderControlsSection()
///   .togglable(ShaderEnabledKey.self)  // Title = "Shader Effects"
/// ```
///
/// Explicit title with external binding
/// ```
/// @State private var customToggle = false
/// SomeView()
///   .togglable("Custom Control", binding: $customToggle)
/// ```
///
/// Transient (non-persisted) toggle
/// ```
/// TemporarySection()
///   .togglable("Show Preview", transient: false)
/// ```
// A private modifier that takes the configuration directly.
private struct ToggledViewModifier: ViewModifier {
  
  let title: String
  @OptionallyPersisted var isEnabled: Bool
  
  init(_ config: ToggleConfiguration) {
    self.title = config.title
    self._isEnabled = config.asPropertyWrapper // The Fix again
  }
  
  func body(content: Content) -> some View {
    ToggledViewCommon(title, isEnabled: $isEnabled) {
      content
    }
  }
}
//struct ToggledViewModifier: ViewModifier {
//
//  let title: String
//  @OptionallyPersisted var isEnabled: Bool
//
//  fileprivate init(
//    configuration: ToggleConfiguration
//  ) {
//    self.title = configuration.title
//    self._isEnabled = configuration.persistedValue
//  }
//
//  func body(content: Content) -> some View {
//    ToggledViewCommon(title, isEnabled: $isEnabled) {
//      content
//    }
//  }
//}

// MARK: - View Extensions
// These are now purely factories for ToggleConfiguration

public extension View {
  
  func togglable<K: ToggleKey>(_ key: K.Type) -> some View {
    self.modifier(ToggledViewModifier(ToggleConfiguration(key)))
  }
  
  func togglable(
    _ title: String = "Enabled",
    binding: Binding<Bool>
  ) -> some View {
    self.modifier(ToggledViewModifier(ToggleConfiguration(title, binding: binding)))
  }
  
  func togglable(
    _ title: String = "Enabled",
    transient defaultValue: Bool = true
  ) -> some View {
    self.modifier(ToggledViewModifier(ToggleConfiguration(title, transient: defaultValue)))
  }
}

//extension View {
//
//  /// Type-safe togglable view with persistence key. Title is derived from key
//  public func togglable<K: ToggleKey>(_ key: K.Type) -> some View {
//    self.modifier(ToggledViewModifier(configuration: ToggleConfiguration(key)))
//  }
//
//  /// Togglable view with external binding, with explicit title
//  public func togglable(
//    _ title: String = "Enabled",
//    binding: Binding<Bool>
//  ) -> some View {
//    self.modifier(ToggledViewModifier(configuration: ToggleConfiguration(title, binding: binding)))
//  }
//
//  /// Togglable view with transient state, in case persistence isn't needed
//  public func togglable(
//    _ title: String = "Enabled",
//    transient defaultValue: Bool = true
//  ) -> some View {
//    self.modifier(ToggledViewModifier(configuration: ToggleConfiguration(title, transient: defaultValue)))
//  }
//}
