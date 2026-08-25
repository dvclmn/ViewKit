//
//  HBarView.swift
//  Components
//
//  Created by Dave Coleman on 9/12/2024.
//

import CoreTools
import StringTools
import SwiftUI
import ViewKitCore
import ViewTools

public struct InfoBarView: View {
  @Environment(\.modifierKeys) private var modifierKeys

  let sections: [InfoBarSection]
  let showingModifiersSection: Bool

  // MARK: - Initialisers
  public init(
    sections: [InfoBarSection],
    showingModifiersSection: Bool = false,
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
        preset: .standard,
      )
    }
    let section = InfoBarSection(
      id: InfoBarSectionID(sectionKey),
      title: sectionKey.title,
      items: items,
    )
    self.sections = [section]
  }

  // MARK: - View body
  public var body: some View {

    InfoBarContainer(isEmpty: isEmpty) {
      ForEach(sections) { section in
        InfoBarSectionView(sectionTitle: section.title, items: section.items)
      }

      if showingModifiersSection {
        InfoBarSectionView(
          sectionTitle: "Modifiers",
          items: [.modifiersSection(modifierKeys)],
        )
      }
    }
  }
}

extension InfoBarView {
  private var isEmpty: Bool {
    sections.isEmpty && !showingModifiersSection
  }
}
