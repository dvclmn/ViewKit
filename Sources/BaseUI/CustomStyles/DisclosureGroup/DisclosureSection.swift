//
//  DisclosureSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//

import SwiftUI
import CoreTools

public struct DisclosureSection<Content: View>: View {

  let title: String
  @Binding var isExpanded: Bool
  let content: Content

  public init(
    _ title: String,
    isExpanded: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self._isExpanded = isExpanded
    self.content = content()
  }

  public var body: some View {

    Section {
      if isExpanded {
        content
      } else {
        Label("Hidden", systemImage: Icons.eye.icon)
          .symbolVariant(.slash.fill)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(.tertiary)
      }
    } header: {
      HStack {
        Text(title)
        Spacer()
        ToggleButton()
      }
    }
  }
}

extension DisclosureSection {
  @ViewBuilder
  private func ToggleButton() -> some View {

    Toggle(isOn: $isExpanded) {
      Text(isExpanded ? "Hide" : "Show")
        .foregroundColor(
          isExpanded
            ? .secondary.opacity(0.5)
            : .secondary.opacity(0.8)
        )
        .font(.caption.weight(.medium))
        .textCase(.uppercase)
    }
    .buttonStyle(.plain)
    .toggleStyle(.button)
    .controlSize(.small)
  }
}
