//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

struct ToggledViewModifier: ViewModifier {

  let title: String
  @OptionallyPersisted var isEnabled: Bool
  let defaultEnabled: Bool

  func body(content: Content) -> some View {
    ToggledViewCommon<Content>(title, isEnabled: $isEnabled) {
      content
    }
  }
}

extension View {
  public func togglable(
    _ title: String = "Enabled",
    persistenceKey: String? = nil,
    defaultEnabled: Bool = true,
  ) -> some View {
    self.modifier(
      ToggledViewModifier(
        title: title,
        isEnabled: OptionallyPersisted(
          defaultValue: defaultEnabled,
          persistenceKey: persistenceKey
        ),
        defaultEnabled: defaultEnabled,
      )
    )
  }
}
