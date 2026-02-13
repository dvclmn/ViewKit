//
//  HBarView.swift
//  Components
//
//  Created by Dave Coleman on 9/12/2024.
//

import BasePrimitives
import SwiftUI

public struct InfoBarView: View {
  @Environment(\.backgroundStyle) private var backgroundStyle
  @Environment(\.modifierKeys) private var modifierKeys

  let sections: [GroupedSection]
  let showingModifiersSection: Bool
  //  let items: [InfoBarSectionID: [InfoBarItem]]

  public init(
    sections: [GroupedSection],
    showingModifiersSection: Bool = false
  ) {
    //    let grouped = Dictionary(grouping: items, by: \.sectionKey)
    //    self.items = grouped
    self.sections = sections
    self.showingModifiersSection = showingModifiersSection
  }

  public var body: some View {

    ScrollView(.horizontal) {

      HStack(alignment: .firstTextBaseline, spacing: 0) {
        if !sections.isEmpty {
          ForEach(sections) { section in
            InfoBarSectionView(sectionTitle: section.title, items: section.items)
          }  // END foreach
          if showingModifiersSection {
            InfoBarSectionView(
              sectionTitle: "Modifiers",
              items: [.modifiersSection(modifierKeys)]
            )
          }

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

    .background(.tintedMaterial, ignoresSafeAreaEdges: .horizontal)

    //    .background {
    //      Rectangle()
    //        .fill(.thinMaterial)
    //
    //      Rectangle()
    //        .fill(backgroundStyle ?? AnyShapeStyle(.black.opacity(0.06)))
    //    }
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

extension InfoBarView {

  @ViewBuilder
  func NoItems(_ reasonText: String) -> some View {
    Text(reasonText)
      .font(.caption)
      .foregroundStyle(.tertiary)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}
