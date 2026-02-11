//
//  DisclosureSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import CoreTools
import SwiftUI

public struct DisclosureSection<Content: View>: View {

  let title: String
  @OptionallyPersisted var isExpanded: Bool
  let content: Content

  private init(
    configuration: ToggleConfiguration,
    @ViewBuilder content: () -> Content
  ) {
    self.title = configuration.title
    self._isExpanded = configuration.persistedValue
    self.content = content()
  }

  /// Key-based init (title derived from key)
  public init<K: ToggleKey>(
    _ key: K.Type,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(key), content: content)
  }

  /// Binding-based, with explicit title
  public init(
    _ title: String,
    binding: Binding<Bool>,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, binding: binding), content: content)
  }

  /// Transient (non-persisted) variant
  public init(
    _ title: String,
    transient defaultExpanded: Bool = true,
    @ViewBuilder content: () -> Content
  ) {
    self.init(configuration: ToggleConfiguration(title, transient: defaultExpanded), content: content)
  }

  public var body: some View {

    Section {
      if isExpanded {
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
