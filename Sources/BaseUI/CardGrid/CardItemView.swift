//
//  CardItemView.swift
//  ViewKit
//
//  Created by Dave Coleman on 15/2/2026.
//

import SwiftUI

extension CardGrid {

  struct ItemView: View {
    @State private var isHovering: Bool = false
    let item: Item
    let cardSize: CGSize
    @ViewBuilder var content: CardItem

    var body: some View {

      if #available(macOS 15, iOS 18, *) {

        ForEach(subviews: content(item, isHovering)) { subview in
          ItemSubview(
            isHovering: $isHovering,
            item: item,
            cardSize: cardSize,
            subview: subview
          )
          .environment(\.isEmphasised, subview.containerValues.isEmphasised)
          .environment(\.isHovering, isHovering)
        }

      } else {
        content(item, isHovering)
          .modifier(CardViewItemModifier(cardSize: cardSize))
          .environment(\.isHovering, isHovering)
      }  // END if available
    }  // END view body
  }
}
