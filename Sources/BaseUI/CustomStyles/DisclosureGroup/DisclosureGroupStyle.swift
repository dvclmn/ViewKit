//
//  DisclosureGroupStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI

public struct QuickDisclosureStyle: DisclosureGroupStyle {
  public func makeBody(configuration: Configuration) -> some View {
    VStack {
      Button {
        configuration.isExpanded.toggle()

      } label: {
        HStack(alignment: .firstTextBaseline) {
          configuration.label
            .foregroundStyle(configuration.isExpanded ? .primary : .secondary)

          Spacer()

          Text(configuration.isExpanded ? "Hide" : "Show")
            .foregroundColor(
              configuration.isExpanded
                ? .secondary.opacity(0.5)
                : .secondary.opacity(0.8)
            )
            .font(.caption.weight(.medium))
            .textCase(.uppercase)
            .animation(nil, value: configuration.isExpanded)
        }
        .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      if configuration.isExpanded {
        configuration.content
      }
    }
  }
}

extension DisclosureGroupStyle where Self == QuickDisclosureStyle {
  public static var custom: Self { Self() }
}
