//
//  DisclosureGroupStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 24/1/2026.
//

import CoreTools
import ViewTools
import SwiftUI

public struct QuickDisclosureStyle: DisclosureGroupStyle {
  public func makeBody(configuration: Configuration) -> some View {

    VStack(spacing: Styles.sizeSmall) {

      if configuration.isExpanded {
        configuration.content
        
      } else {
        Text("Content hidden")
          .font(.caption2)
          .foregroundStyle(.tertiary)
          .italic()
          .frame(maxWidth: .infinity, alignment: .leading)
      }
    }
    .padding(.top, Styles.sizeMedium)

    .overlay(alignment: .topTrailing) {
      Button {
        configuration.isExpanded.toggle()

      } label: {
        Text(configuration.isExpanded ? "Hide" : "Show")
          .foregroundColor(
            configuration.isExpanded
              ? .secondary.opacity(0.5)
              : .secondary.opacity(0.8)
          )
          .font(.caption.weight(.medium))
          .textCase(.uppercase)
          .animation(nil, value: configuration.isExpanded)
          .contentShape(.rect)

      }  // END button
      .buttonStyle(.plain)
    }
  }
}

extension DisclosureGroupStyle where Self == QuickDisclosureStyle {
  public static var sectioned: Self { Self() }

  @available(*, deprecated, renamed: "sectioned", message: "Prefer the more clearly nameded 'sectioned'")
  public static var custom: Self { Self() }
}
