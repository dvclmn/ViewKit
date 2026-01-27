//
//  DisclosureGroupStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 24/1/2026.
//

import SwiftUI

public struct QuickDisclosureStyle: DisclosureGroupStyle {
  public func makeBody(configuration: Configuration) -> some View {
    Section {
      //    VStack {

      if configuration.isExpanded {
        configuration.content
      } else {
        Text("Content hidden")
          .font(.caption2)
          .foregroundStyle(.tertiary)
          .italic()
      }
    } header: {
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
      //      configuration.label
    }
  }
}

extension DisclosureGroupStyle where Self == QuickDisclosureStyle {
  public static var sectioned: Self { Self() }

  @available(*, deprecated, renamed: "sectioned", message: "Prefer the more clearly nameded 'sectioned'")
  public static var custom: Self { Self() }
}
