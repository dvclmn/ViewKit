//
//  CardGridView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import LayoutKit
import SwiftUI

//import SwiftUI
//
//struct CustomView<Content: View>: View {
//
//  let content: Content
//
//  init(
//    @ViewBuilder content: @escaping () -> Content
//  ) {
//    self.content = content()
//  }
//
//  var body: some View {
//    content
//  }
//}

public struct CardGrid<Item: LabeledItem>: View {

  @State private var isHovering: Bool = false
//  let label: QuickLabel
  let data: [Item]
  let cardSize: CGSize

  public init(
//    label: QuickLabel,
    data: [Item],
    cardSize: CGSize = .localPreset
  ) {
//    self.label = label
    self.data = data
    self.cardSize = cardSize
  }


  public var body: some View {

    VStack(alignment: .leading, spacing: Styles.sizeMedium) {
      //      Text("Select an element")

      LazyVGrid(
        columns: .adaptive(
          mode: .fixedWidth(width: cardSize.width),
          spacing: Styles.sizeRegular,
          alignment: .center
        ),
        alignment: .center,
        spacing: Styles.sizeRegular
      ) {

        ForEach(data) { item in
          //        ForEach(SampleContent.Animal.withSymbols()) { animal in

          MaybeLabel(item.label)
            //            .foregroundStyle(.secondary)
            .labelStyle(.base)
            .environment(\.labelDisplay, .stacked)
            .environment(\.symbolRenderingMode, .hierarchical)
            .environment(\.symbolVariants, .fill)
            .frame(
              width: cardSize.width,
              height: cardSize.height,
              alignment: .center
            )
            .quickBackground(
              shape: .rect(cornerRadius: Styles.sizeSmall.bump),
              padding: .zero
            )
            .backgroundTint(.white.opacity(0.1))
            .onHover { isHovering = $0 }
        }
      }  // END lazy grid
    }  // END main vstack
    .weightedPadding(Styles.sizeMedium.bump)
    .frame(maxWidth: 440)

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
  )
  // .environment(store)
}
#endif

extension CGSize {
  @usableFromInline
  static var localPreset: Self { .init(width: 100, height: 80) }
}
