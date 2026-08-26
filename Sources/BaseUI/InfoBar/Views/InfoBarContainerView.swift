//
//  InfoBarContainerView.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/8/2026.
//

import SwiftUI
import ViewTools

struct InfoBarContainer<Content: View>: View {
  @Environment(\.backgroundStyle) private var backgroundStyle
  @Environment(\.isLoading) private var isLoading
  @Environment(\.infoBarConfiguration) private var config

  let isEmpty: Bool
  let content: Content

  init(
    isEmpty: Bool,
    @ViewBuilder content: () -> Content,
  ) {
    self.isEmpty = isEmpty
    self.content = content()
  }

  var body: some View {
    if !isLoading {
      ScrollView(.horizontal) {
        HStack(alignment: .firstTextBaseline, spacing: config.itemSpacing) {
          if isEmpty {
            noItems("No items to display")
          } else {
            content
            Spacer()
          }
        }
        // A single bit of padding at the start and the end
        .safeAreaPadding(.horizontal, config.barPaddingH)
      }
      .scrollBounceBehavior(.basedOnSize)
      .scrollIndicators(.hidden)
      .frame(height: config.barHeight)
      .background(.thinMaterial, ignoresSafeAreaEdges: .horizontal)
      .background(
        backgroundStyle ?? AnyShapeStyle(.black.opacity(0.06)),
        ignoresSafeAreaEdges: .horizontal,
      )
      // Thin horizontal highlight across the top
      .overlay(alignment: .top) {
        Rectangle()
          .fill(.white.opacity(0.02))
          .frame(maxWidth: .infinity, maxHeight: 1)
      }
      .monospacedDigit()
      .font(.callout)
//      .environment(\.layoutAxis, .horizontal)
//      .environment(\.layoutAlignment, .leading)
//      .environment(\.layoutSpacing, .zero)
    }
  }
}

extension InfoBarContainer {

  @ViewBuilder
  private func noItems(_ reasonText: String) -> some View {
    Text(reasonText)
      .foregroundStyle(.tertiary)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}
