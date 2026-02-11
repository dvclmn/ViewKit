//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI
import CoreTools

struct ToggledViewModifier<K: ToggleKey>: ViewModifier {
  
  let keyType: K.Type
  @OptionallyPersisted var isEnabled: Bool
  
  init(key: K.Type) {
    self.keyType = key
    self._isEnabled = OptionallyPersisted(key)
  }
  
  func body(content: Content) -> some View {
    ToggledViewCommon<Content>(
      K.displayName,
      isEnabled: $isEnabled
    ) {
      content
    }
  }
}

extension View {
  /// Type-safe togglable view
  public func togglable<K: ToggleKey>(_ key: K.Type) -> some View {
    self.modifier(ToggledViewModifier(key: key))
  }
  
  /// External binding variant
  public func togglable(
    _ title: String = "Enabled",
    binding: Binding<Bool>
  ) -> some View {
    self.modifier(
      ToggledViewModifier(
        title: title,
        isEnabled: OptionallyPersisted(binding: binding)
      )
    )
  }
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
