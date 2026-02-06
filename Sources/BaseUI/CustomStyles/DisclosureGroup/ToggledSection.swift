//
//  ToggledSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import SwiftUI

public struct ToggledView<Content: View>: View {

  // Future: customisable toggle label
  // Internal ephemeral fallback
  @State private var transientEnabled: Bool

  @AppStorage private var persistedEnabled: Bool
  private let usesPersistence: Bool

  // The single source of truth the view will use
  private var enabled: Binding<Bool> {
    return usesPersistence ? $persistedEnabled : $transientEnabled
  }

  /// This is the view to be toggled
  let content: Content

  public init(
//    _ title: String,
    defaultEnabled: Bool = true,
    persistenceKey: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    //    self.externalExpanded = nil

    self._transientEnabled = State(initialValue: defaultEnabled)

    if let persistenceKey {
      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, persistenceKey)
      self.usesPersistence = true
    } else {
      // Key won't be used because usesPersistence == false
      self._persistedEnabled = AppStorage(wrappedValue: defaultEnabled, "unused.disclosure.key")
      self.usesPersistence = false
    }
  }

  public var body: some View {

    Toggle("Enabled", isOn: enabled)
      .foregroundStyle(enabled.wrappedValue ? .primary : .tertiary)
    if enabled.wrappedValue {
      content
    }
  }
}
