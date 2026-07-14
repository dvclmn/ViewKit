//
//  CardItemSubview.swift
//  ViewKit
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI
import ViewTools

extension CardGrid {

  @available(macOS 15, iOS 18, *)
  struct ItemSubview: View {
    @Environment(\.isEmphasised) private var isEmphasised

    @Binding var isHovering: Bool
    let item: Item
    let cardSize: CGSize
    let subview: Subview

    var body: some View {
      subview
        .modifier(ItemViewCommonModifier(cardSize: cardSize))
        .onHover { isHovering = $0 }

    }
  }
}
