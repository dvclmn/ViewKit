//
//  CardGridView.swift
//  ViewKit
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

public struct CardGrid<Item: LabeledItem & Equatable, Content: View>: View {
  @Environment(\.colourOverride) private var colourOverride
  public typealias CardItem = (Item, Bool) -> Content

  let data: [Item]
  let sections: [CardGridSection<Item>]?
  let alignment: HorizontalAlignment
  let cardSize: CGSize
  let pinnedViews: PinnedScrollableViews
  let content: CardItem

  // MARK: - Initialisers
  /// Creates an ungrouped card grid.
  public init(
    data: [Item],
    alignment: HorizontalAlignment = .leading,
    cardSize: CGSize = .localPreset,
    pinnedViews: PinnedScrollableViews = .init(),
    @ViewBuilder content: @escaping CardItem,
  ) {
    self.data = data
    self.sections = nil
    self.alignment = alignment
    self.cardSize = cardSize
    self.pinnedViews = pinnedViews
    self.content = content
  }

  /// Creates a card grid from prepared sections.
  ///
  /// Prefer this initialiser when the collection is dynamic or grouping is
  /// non-trivial. Prepare the sections when their source data changes, rather
  /// than deriving them from a SwiftUI view body.
  public init(
    sections: [CardGridSection<Item>],
    alignment: HorizontalAlignment = .leading,
    cardSize: CGSize = .localPreset,
    pinnedViews: PinnedScrollableViews = .init(),
    @ViewBuilder content: @escaping CardItem,
  ) {
    self.data = []
    self.sections = sections
    self.alignment = alignment
    self.cardSize = cardSize
    self.pinnedViews = pinnedViews
    self.content = content
  }

  /// Creates a grouped card grid using a typed group value for each item.
  ///
  /// The group value supplies both the stable section identity and its header
  /// label through ``LabeledItem``. `sectionOrder` is honoured first; any
  /// remaining groups follow their first occurrence in `data`.
  ///
  /// This convenience initialiser groups its data whenever SwiftUI recreates
  /// the grid value. For dynamic or costly grouping, prepare
  /// ``CardGridSection`` values outside the view body and use
  /// ``init(sections:alignment:cardSize:pinnedViews:content:)`` instead.
  public init<Group>(
    data: [Item],
    groupedBy groupPath: KeyPath<Item, Group>,
    sectionOrder: [Group] = [],
    alignment: HorizontalAlignment = .leading,
    cardSize: CGSize = .localPreset,
    pinnedViews: PinnedScrollableViews = .init(),
    @ViewBuilder content: @escaping CardItem,
  ) where Group: Hashable & LabeledItem {
    self.init(
      sections: CardGridSection.grouped(data, by: groupPath, order: sectionOrder),
      alignment: alignment,
      cardSize: cardSize,
      pinnedViews: pinnedViews,
      content: content,
    )
  }

  // MARK: - View body
  public var body: some View {

    LazyVGrid(
      columns: .adaptive(
        mode: .fixedWidth(width: cardSize.width),
        spacing: Styles.sizeRegular,
        alignment: .center,
      ),
      alignment: alignment,
      spacing: Styles.sizeRegular,
      pinnedViews: pinnedViews,
    ) {
      if let sections {
        ForEach(sections) { section in
          Section {
            ForEach(section.items) { item in
              ItemView(item: item, cardSize: cardSize, content: content)
            }
          } header: {
            QuickLabel(section.label)
              .fontWeight(.semibold)
              .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
      } else {
        ForEach(data) { item in
          ItemView(item: item, cardSize: cardSize, content: content)
        }
      }
    }  // END lazy grid

  }
}

extension CardGrid {

}
#if DEBUG
#Preview {
  // @Previewable @State var store = AppHandler()
  CardGrid(
    //    label: LabelDescriptor("Hello", symbol: "eye"),
    data: SampleContent.Animal.withSymbols(),
    cardSize: .localPreset,
    //  ) { item in
  ) { item, isHovered in
    QuickLabel(item.label)
  }
  // .environment(store)
}
#endif

extension CGSize {
  @usableFromInline
  static var localPreset: Self { .init(width: 100, height: 80) }
}
