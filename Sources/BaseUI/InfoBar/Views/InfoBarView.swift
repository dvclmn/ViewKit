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
  @Environment(\.isLoading) private var isLoading
  @Environment(\.isASCIIMode) private var isASCIIMode
  @Environment(\.asciiModeFontSize) private var asciiModeFontSize

  let sections: [InfoBarSection]
  let showingModifiersSection: Bool

  public init(
    sections: [InfoBarSection],
    showingModifiersSection: Bool = false
  ) {
    self.sections = sections
    self.showingModifiersSection = showingModifiersSection
  }
  
//  public func addInfoBarItems<K: InfoBarSectionKey>(
//    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
//    key: K.Type = DebugSectionKey.self,
//    preset: FloatDisplayPreset = .standard,
//    
//  ) -> some View {
//    self.transformPreference(InfoBarKey.self) { value in
//      let newItems = content().toInfoBarItems(section: key, preset: preset)
//      value.append(contentsOf: newItems)
//    }
//  }


  public init(
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
    showingModifiersSection: Bool = false
  ) {
    // TODO: Make DisplayString able to Declare an InfoBar section?
    
    let sectionKey = DebugSectionKey.self
    let items = content().compactMap {
      InfoBarItem(
        fromBlock: $0,
        section: sectionKey,
        preset: .standard
      )
    }
    let section = InfoBarSection(id: InfoBarSectionID(sectionKey), title: "I don't know", items: items)
    self.sections = [section]
    self.showingModifiersSection = showingModifiersSection
  }

  
  public var body: some View {

    if !isLoading {
      ScrollView(.horizontal) {

        HStack(alignment: .firstTextBaseline, spacing: 0) {
          if !sections.isEmpty {
            ForEach(sections) { section in
              InfoBarSectionView(sectionTitle: section.title, items: section.items)
            }

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

      .gridFont(
        config: .domain(.asciiMode),
        fallback: .caption2.weight(.medium)
      )
      //      .font(.caption)
      //      .fontWeight(.medium)
      .frame(height: Styles.infoBarHeight)
      .background(.thinMaterial, ignoresSafeAreaEdges: .horizontal)
      .background(backgroundStyle ?? AnyShapeStyle(.black.opacity(0.06)), ignoresSafeAreaEdges: .horizontal)

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
}

extension InfoBarView {

  @ViewBuilder
  func NoItems(_ reasonText: String) -> some View {
    Text(reasonText)
      .foregroundStyle(.tertiary)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
  }
}
