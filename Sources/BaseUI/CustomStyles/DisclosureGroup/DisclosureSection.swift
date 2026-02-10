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

  public init(
    _ title: String,
    persistenceKey: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self._isExpanded = OptionallyPersisted(
      defaultValue: true,
      persistenceKey: persistenceKey
    )
    self.content = content()
  }

  public var body: some View {

    Section {
      if isExpanded {
//        VStack(alignment: .leading, spacing: Styles.sizeMedium) {
          content
//        }
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
