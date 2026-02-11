//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import CoreTools
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
struct ToggledViewModifier: ViewModifier {

  let title: String
  @OptionallyPersisted var isEnabled: Bool

  /// Key-based initializer (title derived from key)
  init<K: ToggleKey>(key: K.Type) {
    self.title = K.displayName
    self._isEnabled = OptionallyPersisted(key)
  }

  /// Binding-based initializer (explicit title)
  init(title: String, binding: Binding<Bool>) {
    self.title = title
    self._isEnabled = OptionallyPersisted(binding: binding)
  }

  /// Optional: Transient (non-persisted) initializer
  init(title: String, transient defaultValue: Bool = true) {
    self.title = title
    self._isEnabled = OptionallyPersisted(transient: defaultValue)
  }

  func body(content: Content) -> some View {
    ToggledViewCommon(title, isEnabled: $isEnabled) {
      content
    }
  }
}

//struct ToggledViewModifier<K: ToggleKey>: ViewModifier {
//
//  let keyType: K.Type
//  @OptionallyPersisted var isEnabled: Bool
//
//  init(key: K.Type) {
//    self.keyType = key
//    self._isEnabled = OptionallyPersisted(key)
//  }
//
//  func body(content: Content) -> some View {
//    ToggledViewCommon<Content>(
//      K.displayName,
//      isEnabled: $isEnabled
//    ) {
//      content
//    }
//  }
//}

extension View {

  /// Type-safe togglable view with persistence key
  public func togglable<K: ToggleKey>(_ key: K.Type) -> some View {
    self.modifier(ToggledViewModifier(key: key))
  }

  /// Togglable view with external binding
  public func togglable(
    _ title: String = "Enabled",
    binding: Binding<Bool>
  ) -> some View {
    self.modifier(ToggledViewModifier(title: title, binding: binding))
  }

  /// Togglable view with transient (non-persisted) state
  public func togglable(
    _ title: String = "Enabled",
    transient defaultValue: Bool = true
  ) -> some View {
    self.modifier(ToggledViewModifier(title: title, transient: defaultValue))
  }
  //  /// Type-safe togglable view
  //  public func togglable<K: ToggleKey>(_ key: K.Type) -> some View {
  //    self.modifier(ToggledViewModifier(key: key))
  //  }
  //
  //  /// External binding variant
  //  public func togglable(
  //    _ title: String = "Enabled",
  //    binding: Binding<Bool>
  //  ) -> some View  {
  //    self.modifier(
  //      ToggledViewModifier(
  //        title: title,
  //        isEnabled: OptionallyPersisted(binding: binding)
  //      )
  //    )
  //  }
}

//struct ToggledViewModifier: ViewModifier {
//
//  let title: String
//  @OptionallyPersisted var isEnabled: Bool
//  let defaultEnabled: Bool
//
//  func body(content: Content) -> some View {
//    ToggledViewCommon<Content>(title, isEnabled: $isEnabled) {
//      content
//    }
//  }
//}
//
//extension View {
//  public func togglable(
//    _ title: String = "Enabled",
//    persistenceKey: String? = nil,
//    defaultEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      ToggledViewModifier(
//        title: title,
//        isEnabled: OptionallyPersisted(
//          defaultValue: defaultEnabled,
//          persistenceKey: persistenceKey
//        ),
//        defaultEnabled: defaultEnabled,
//      )
//    )
//  }
//}
