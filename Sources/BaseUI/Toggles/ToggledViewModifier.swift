//
//  ToggledViewModifier.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import SwiftUI

public struct ToggledViewModifier: ViewModifier {

  /// Internal ephemeral fallback
  //  @State private var transientEnabled: Bool
  //  @AppStorage private var persistedEnabled: Bool

  let title: String
  @OptionallyPersisted var isEnabled: Bool
  //  private let usesPersistence: Bool

  public init(_ title: String = "Enabled", defaultEnabled: Bool = true, persistenceKey: String? = nil) {
    self.title = title
    self._isEnabled = OptionallyPersisted(defaultValue: defaultEnabled, persistenceKey: persistenceKey)
  }

  //  public init(
  //    _ title: String = "Enabled",
  //    defaultEnabled: Bool = true,
  //    persistenceKey: String? = nil,
  //  ) {
  //    self.title = title
  //    self._transientEnabled = State(initialValue: defaultEnabled)
  //
  //    if let persistenceKey {
  //      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, persistenceKey)
  //      self.usesPersistence = true
  //    } else {
  //
  //      /// Key won't be used because usesPersistence == false
  //      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, "unused.disclosure.key")
  //      self.usesPersistence = false
  //    }
  //  }

  public func body(content: Content) -> some View {
    VStack {
      Toggle(title, isOn: $isEnabled)
        .foregroundStyle(isEnabled ? .primary : .tertiary)
      if isEnabled {
        content
      }
    }
  }
}

extension ToggledViewModifier {

  /// The single source of truth the view will use
  //  private var isEnabled: Binding<Bool> {
  //    return usesPersistence ? $persistedEnabled : $transientEnabled
  //  }
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
