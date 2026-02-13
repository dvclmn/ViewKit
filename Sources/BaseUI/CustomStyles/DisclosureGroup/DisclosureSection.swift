//
//  DisclosureSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import CoreTools
import SwiftUI

public struct DisclosureSection<Content: View>: View {
  /// If disabled, hiding/showing is not possible
  @Environment(\.isEnabled) private var isControlEnabled
  
  @OptionallyPersisted var isExpanded: Bool
  let title: String
  let content: Content

  private init(
    configuration: ToggleConfiguration,
    @ViewBuilder content: () -> Content
  ) {
    self.title = configuration.title
    self._isExpanded = configuration.asPropertyWrapper
    self.content = content()
  }

  /// These just create the config and pass it to the master init
  public init<K: ToggleKey>(
    _ key: K.Type,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(key), content: content)
  }

  public init(
    _ title: String,
    binding: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, binding: binding), content: content)
  }

  public init(
    _ title: String,
    transient defaultExpanded: Bool = true,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, transient: defaultExpanded), content: content)
  }

  public var body: some View {

    Section {
      if isExpanded || isControlEnabled {
        content

      } else {
        Label("Hidden", systemImage: "eye")
          .symbolVariant(.slash.fill)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.tertiary)
          .labelStyle(.base)
          .iconColour(.secondary)
      }

    } header: {
      
      HStack {
        Text(title)
          .foregroundStyle(isExpanded ? .secondary : .tertiary)

        if isControlEnabled {
          Spacer()
          Toggle(isOn: $isExpanded) {
            Text(isExpanded ? "Hide" : "Show")
              .font(.caption.weight(.medium))
              .textCase(.uppercase)
          }
          .buttonStyle(.plain)
          .toggleStyle(.button)
          .controlSize(.small)
        }
      }
    }
  }
}
