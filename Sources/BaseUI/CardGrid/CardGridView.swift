//
//  CardGridView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import BasePrimitives
import LayoutKit
import SwiftUI

public struct CardGrid<Item: LabeledItem & Equatable, Content: View>: View {
  @Environment(\.colourOverride) private var colourOverride
  public typealias CardItem = (Item, Bool) -> Content

  let data: [Item]
  let alignment: HorizontalAlignment
  let cardSize: CGSize
  let content: CardItem

  public init(
    data: [Item],
    alignment: HorizontalAlignment = .leading,
    cardSize: CGSize = .localPreset,
    @ViewBuilder content: @escaping CardItem
  ) {
    self.data = data
    self.alignment = alignment
    self.cardSize = cardSize
    self.content = content
  }

  public var body: some View {

    LazyVGrid(
      columns: .adaptive(
        mode: .fixedWidth(width: cardSize.width),
        spacing: Styles.sizeRegular,
        alignment: .center
      ),
      alignment: alignment,
      spacing: Styles.sizeRegular
    ) {
      ForEach(data) { item in
        ItemView(item: item, cardSize: cardSize, content: content)
      }
    }  // END lazy grid

  }
}

extension CardGrid {

}
#if DEBUG
#Preview(traits: .size(.normal)) {
  // @Previewable @State var store = AppHandler()
  CardGrid(
    //    label: QuickLabel("Hello", symbol: "eye"),
    data: SampleContent.Animal.withSymbols(),
    cardSize: .localPreset
      //  ) { item in
  ) { item, isHovered in
    MaybeLabel(item.label)
  }
  // .environment(store)
}
#endif

extension CGSize {
  @usableFromInline
  static var localPreset: Self { .init(width: 100, height: 80) }
}
