//
//  HBarView.swift
//  Components
//
//  Created by Dave Coleman on 9/12/2024.
//


import SharedHelpers
import SwiftUI

public struct InfoBar: View {
  @Environment(\.backgroundStyle) private var backgroundStyle

  let items: [String: [InfoBarItem]]

  public init(items: InfoBarItems) {
    let grouped = Dictionary(grouping: items, by: \.section)
    self.items = grouped
  }

  public var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 0) {
      if !items.isEmpty {
        ForEach(items.sorted(byKeyPath: \.key), id: \.key) { key, items in
          InfoBarSectionView(sectionTitle: key, items: items)
        }  // END foreach
        Spacer()
      } else {
        NoItems("No items to display")
      }
    }  // END hstack
    //    .padding(.horizontal, Styles.sizeSmall)
    .font(.caption)
    .fontWeight(.medium)
    .frame(height: Styles.infoBarHeight)
    .background {
      Rectangle()
        .fill(.thinMaterial)
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
