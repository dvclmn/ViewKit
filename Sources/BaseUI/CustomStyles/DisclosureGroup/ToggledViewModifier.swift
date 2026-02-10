//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

public struct ToggledViewModifier: ViewModifier {

  /// Internal ephemeral fallback
  @State private var transientEnabled: Bool
  @AppStorage private var persistedEnabled: Bool

  let title: String
  private let usesPersistence: Bool

  /// This is the view to be toggled
  //  let content: Content

  public init(
    _ title: String = "Enabled",
    defaultEnabled: Bool = true,
    persistenceKey: String? = nil,
    //    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    //    self.content = content()
    self._transientEnabled = State(initialValue: defaultEnabled)

    if let persistenceKey {
      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, persistenceKey)
      self.usesPersistence = true
    } else {
      /// Key won't be used because usesPersistence == false
      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, "unused.disclosure.key")
      self.usesPersistence = false
    }
  }

  public func body(content: Content) -> some View {
    VStack {
      Toggle(title, isOn: isEnabled)
        .foregroundStyle(isEnabled.wrappedValue ? .primary : .tertiary)
      if isEnabled.wrappedValue {
        content
      }
    }
    //    content
  }
}

extension ToggledViewModifier {

  /// The single source of truth the view will use
  private var isEnabled: Binding<Bool> {
    return usesPersistence ? $persistedEnabled : $transientEnabled
  }
}

extension View {
  public func togglable(
    _ title: String = "Enabled",
    persistenceKey: String? = nil,
    defaultEnabled: Bool = true,
  ) -> some View {
    self.modifier(ToggledViewModifier())
  }
}
