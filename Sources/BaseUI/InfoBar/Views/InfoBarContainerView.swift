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
  
  let isEmpty: Bool
  let content: Content
  
  init(
    isEmpty: Bool,
    @ViewBuilder content: () -> Content
  ) {
    self.isEmpty = isEmpty
    self.content = content()
  }
  
  var body: some View {
    if !isLoading {
      ScrollView(.horizontal) {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
          if isEmpty {
            noItems("No items to display")
          } else {
            content
            Spacer()
          }
        }
        .safeAreaPadding(.horizontal, Styles.sizeTiny)
      }
      .scrollBounceBehavior(.basedOnSize)
      .scrollIndicators(.hidden)
      .frame(height: Styles.infoBarHeight)
      .background(.thinMaterial, ignoresSafeAreaEdges: .horizontal)
      .background(
        backgroundStyle ?? AnyShapeStyle(.black.opacity(0.06)),
        ignoresSafeAreaEdges: .horizontal
      )
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
}

extension InfoBarContainer {
  
  @ViewBuilder
  private func noItems(_ reasonText: String) -> some View {
    Text(reasonText)
      .foregroundStyle(.tertiary)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}
