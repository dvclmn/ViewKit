//
//  HBarView.swift
//  Components
//
//  Created by Dave Coleman on 9/12/2024.
//

import CoreTools
import ViewTools
import SwiftUI
import ViewKitCore
import StringTools

public struct InfoBarView: View {
  @Environment(\.modifierKeys) private var modifierKeys

  let sections: [InfoBarSection]
  let showingModifiersSection: Bool

  public init(
    sections: [InfoBarSection],
    showingModifiersSection: Bool = false
  ) {
    self.sections = sections
    self.showingModifiersSection = showingModifiersSection
  }

  public init(
    showingModifiersSection: Bool = false,
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
  ) {
    self.showingModifiersSection = showingModifiersSection
    // TODO: Make DisplayString able to Declare an InfoBar section?
    let sectionKey = DebugSectionKey.self
    let items = content().compactMap {
      InfoBarItem(
        fromBlock: $0,
        section: sectionKey,
        preset: .standard
      )
    }
    let section = InfoBarSection(
      id: InfoBarSectionID(sectionKey),
      title: sectionKey.title,
      items: items
    )
    self.sections = [section]

  }

  public var body: some View {
    InfoBarContainer(isEmpty: sections.isEmpty && !showingModifiersSection) {
      ForEach(sections) { section in
        InfoBarSectionView(sectionTitle: section.title, items: section.items)
      }

      if showingModifiersSection {
        InfoBarSectionView(
          sectionTitle: "Modifiers",
          items: [.modifiersSection(modifierKeys)]
        )
      }
    }
  }
}

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
