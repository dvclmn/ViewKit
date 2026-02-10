//
//  ToggledSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public struct ToggledView<Content: View>: View {

  /// Future: customisable toggle label
  /// Internal ephemeral fallback
  @State private var transientEnabled: Bool

  @AppStorage private var persistedEnabled: Bool
  private let usesPersistence: Bool

  let title: String

  /// This is the view to be toggled
  let content: Content

  public init(
    _ title: String = "Enabled",
    defaultEnabled: Bool = true,
    persistenceKey: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
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

  public var body: some View {

    VStack {
      Toggle(title, isOn: isEnabled)
        .foregroundStyle(isEnabled.wrappedValue ? .primary : .tertiary)
      if isEnabled.wrappedValue {
        content
      }
    }
  }
}

extension ToggledView {

  /// The single source of truth the view will use
  private var isEnabled: Binding<Bool> {
    return usesPersistence ? $persistedEnabled : $transientEnabled
  }

}
