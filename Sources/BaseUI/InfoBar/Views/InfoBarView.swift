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

  let items: [InfoBarItem]
  let sections: [InfoBarSection]
  let showingModifiersSection: Bool

  // MARK: - Initialisers
  public init(
    items: [InfoBarItem],
    sections: [InfoBarSection],
    showingModifiersSection: Bool = false,
  ) {
    self.items = items
    self.sections = sections
    self.showingModifiersSection = showingModifiersSection
  }

  /// Creates an InfoBar containing unsectioned items.
  public init(
    items: [InfoBarItem],
    showingModifiersSection: Bool = false,
  ) {
    self.init(
      items: items,
      sections: [],
      showingModifiersSection: showingModifiersSection,
    )
  }

  /// Creates an InfoBar containing explicitly grouped sections.
  public init(
    sections: [InfoBarSection],
    showingModifiersSection: Bool = false,
  ) {
    self.init(
      items: [],
      sections: sections,
      showingModifiersSection: showingModifiersSection,
    )
  }

  public init(
    showingModifiersSection: Bool = false,
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
  ) {
    self.init(
      items: content().toInfoBarItems(preset: .standard),
      sections: [],
      showingModifiersSection: showingModifiersSection,
    )
  }

  // MARK: - View body
  public var body: some View {

    InfoBarContainer(isEmpty: isEmpty) {
      ForEach(items) { item in
        InfoBarItemView(item: item)
      }

      ForEach(sections) { section in
        InfoBarSectionView(sectionTitle: section.title, items: section.items)
      }

      if showingModifiersSection {
        InfoBarSectionView(
          sectionTitle: "Modifiers",
          items: [.modifiersItem(modifierKeys)],
        )
      }
    }
  }
}

extension InfoBarView {
  private var isEmpty: Bool {
    items.isEmpty && sections.isEmpty && !showingModifiersSection
  }
}
