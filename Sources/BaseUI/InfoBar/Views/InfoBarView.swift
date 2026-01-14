//
//  HBarView.swift
//  Components
//
//  Created by Dave Coleman on 9/12/2024.
//

import BasePrimitives
import SwiftUI

public struct InfoBar: View {
  @Environment(\.backgroundStyle) private var backgroundStyle
  @Environment(\.modifierKeys) private var modifierKeys

  let items: [InfoBarSectionID: [InfoBarItem]]

  public init(items: [InfoBarItem]) {
    let grouped = Dictionary(grouping: items, by: \.sectionKey)
    self.items = grouped
  }

  public var body: some View {

    ScrollView(.horizontal) {

      HStack(alignment: .firstTextBaseline, spacing: 0) {
        if !items.isEmpty {
          ForEach(
            items.sorted(byKeyPath: \.key.title), id: \.key
          ) { key, items in

            InfoBarSectionView(sectionTitle: key.title, items: items)

          }  // END foreach
          InfoBarSectionView(
            sectionTitle: "Modifiers",
            items: [.modifiersSection(modifierKeys)]
          )

          Spacer()
        } else {
          NoItems("No items to display")
        }
      }  // END hstack
      .safeAreaPadding(.horizontal, Styles.sizeTiny)
    }
    .scrollBounceBehavior(.basedOnSize)
    .scrollIndicators(.hidden)

    .font(.caption)
    .fontWeight(.medium)
    .frame(height: Styles.infoBarHeight)

    .background {
      Rectangle()
        .fill(.thinMaterial)

      Rectangle()
        .fill(backgroundStyle ?? AnyShapeStyle(.black.opacity(0.06)))
    }
    /// Small top highlight for contrast against background
    .overlay(alignment: .top) {
      Rectangle()
        .fill(.white.opacity(0.02))
        .frame(maxWidth: .infinity, maxHeight: 1)
    }

    .monospacedDigit()

    .environment(\.layoutAxis, .horizontal)
    .environment(\.layoutAlignment, .leading)
    .environment(\.layoutSpacing, .zero)
    .environment(\.symbolVariants, .fill)

  }
}

extension InfoBar {

  @ViewBuilder
  func NoItems(_ reasonText: String) -> some View {
    Text(reasonText)
      .font(.caption)
      .foregroundStyle(.tertiary)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}
