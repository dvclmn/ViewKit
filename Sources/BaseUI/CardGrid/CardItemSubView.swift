//
//  CardItemSubView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
//

import CoreTools
import SwiftUI

extension CardGrid {

    @available(macOS 15, iOS 18, *)
  struct ItemSubView: View {

    @State private var isHovering: Bool = false

    let item: Item
    let cardSize: CGSize
        let subview: Subview
//    @ViewBuilder var content: CardItem
    //    @ViewBuilder var content: CardItem

    var body: some View {
      subview
//            content
//      content(item)
        //      content(item, isHovering)
        .labelStyle(.base)
        .environment(\.labelDisplay, .stacked)
        .environment(\.symbolRenderingMode, .hierarchical)
        .environment(\.symbolVariants, .fill)
        .multilineTextAlignment(.center)
        .padding(Styles.sizeTiny)
        .frame(
          width: cardSize.width,
          height: cardSize.height,
          alignment: .center
        )
        .quickBackground(
          shape: .rect(cornerRadius: Styles.sizeSmall.bump),
          padding: .zero
        )
        //        .backgroundTint(.white.opacity(isEmphasised ? 0.2 : 0.08))
        .onHover { isHovering = $0 }

    }
  }

  //  public struct CardViewItemModifier: ViewModifier {
  //
  //    public func body(content: Content) -> some View {
  //      content
  //        .labelStyle(.base)
  //        .environment(\.labelDisplay, .stacked)
  //        .environment(\.symbolRenderingMode, .hierarchical)
  //        .environment(\.symbolVariants, .fill)
  //        .multilineTextAlignment(.center)
  //        .padding(Styles.sizeTiny)
  //        .frame(
  //          width: cardSize.width,
  //          height: cardSize.height,
  //          alignment: .center
  //        )
  //        .quickBackground(
  //          shape: .rect(cornerRadius: Styles.sizeSmall.bump),
  //          padding: .zero
  //        )
  //        .backgroundTint(.white.opacity(isEmphasised ? 0.2 : 0.08))
  //
  //    }
  //  }
}
