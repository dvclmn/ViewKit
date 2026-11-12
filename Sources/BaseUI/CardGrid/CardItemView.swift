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

      // NOTE: The container value is required here to allow an Item within container view `CardView` to declare `isEmphasised`.
      // An Environment value alone can only pass data further down
      // the view hierarchy, not back up to it's container.
      // The container value modifier catches the value, if declared, and passes it to the environment
      // to be styled from within `ItemViewCommonModifier`
      Group {
        if #available(macOS 15, iOS 18, *) {

          ForEach(subviews: content(item, isHovering)) { subview in
            subview
              .modifier(ItemViewCommonModifier(cardSize: cardSize))
              .environment(
                \.isEmphasised,
                subview.containerValues.isEmphasised,
              )
          }

        } else {

          // Older macOS versions will get no emphasised styling
          content(item, isHovering)
            .modifier(ItemViewCommonModifier(cardSize: cardSize))

        }  // END if available
      }  // END group

      .onHover { isHovering = $0 }
      .environment(\.isHovering, isHovering)

    }  // END view body
  }
}
