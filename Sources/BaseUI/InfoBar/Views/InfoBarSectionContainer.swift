//
//  InfoBarSectionContainer.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import CoreTools
import SwiftUI
import ViewTools

/// Shared section chrome for model-backed and registered InfoBar content.
struct InfoBarSectionContainer<Content: View>: View {
  @Environment(\.sectionLabelDisplay) private var sectionLabelDisplay

  let title: String
  let content: Content

  private let itemSpacing: CGFloat = Styles.sizeTiny

  init(
    title: String,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.content = content()
  }

  var body: some View {
    Section {
      HStack(spacing: itemSpacing) {
        content
      }
      .labelStyle(.base)
      .foregroundStyle(.secondary)
      .labelIconSpacingCompatible(4)
    } header: {
      QuickLabel(title)
        .environment(\.labelDisplay, sectionLabelDisplay)
        .fontWeight(.semibold)
        .frame(maxHeight: .infinity)
        .padding(.horizontal, Styles.sizeTiny.bump)
        .background(.black.opacity(0.4))
        .overlay(alignment: .trailing) {
          Rectangle()
            .fill(.white.opacity(0.07))
            .frame(width: 1)
            .frame(maxHeight: .infinity)
        }
        .padding(.trailing, itemSpacing)
    }
  }
}
