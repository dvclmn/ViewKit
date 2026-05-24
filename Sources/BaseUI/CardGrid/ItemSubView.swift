//
//  CardItemSubView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/2/2026.
import CoreTools
import ViewTools
import SwiftUI

extension CardGrid {

  @available(macOS 15, iOS 18, *)
  struct ItemSubView: View {
    @Environment(\.isEmphasised) private var isEmphasised

    @Binding var isHovering: Bool
    let item: Item
    let cardSize: CGSize
    let subview: Subview

    var body: some View {
      subview
        .modifier(CardViewItemModifier(cardSize: cardSize))
        .onHover { isHovering = $0 }

    }
  }

}
public struct CardViewItemModifier: ViewModifier {
  @Environment(\.isEmphasised) private var isEmphasised
  @Environment(\.isHovering) private var isHovering
  let cardSize: CGSize
  public func body(content: Content) -> some View {
    content
      .labelStyle(.base)
      .environment(\.labelDisplay, .stacked)
      .environment(\.symbolRenderingMode, .hierarchical)
      .environment(\.symbolVariants, .fill)
      .iconColour(isEmphasised ? .primary : .secondary)
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
      .backgroundTint(.white.opacity(tintOpacity))
  }
}

extension CardViewItemModifier {
  private var isEmphasisedOrHovered: Bool {
    isEmphasised || isHovering
  }

  private var isEmphasisedAndHovered: Bool {
    isEmphasised && isHovering
  }

  private var tintOpacity: CGFloat {
    switch (isHovering, isEmphasised) {
      case (_, true): return 0.9
      case (true, _): return 0.4
      default: return 0.0
    //      case (true, false): return 0.5
    //      case (false, true): return 0.4
    //      case (false, false): return 0.0
    }
  }

  //  private func tintOpacityScale(base: CGFloat) -> CGFloat {
  //    let factor: CGFloat =
  //    switch (isHovering, isEmphasised) {
  //      case (_, true): 2
  //      case (true, _): 0.5
  //      default: 1
  //        //      case (true, false): return 0.5
  //        //      case (false, true): return 0.4
  //        //      case (false, false): return 0.0
  //    }
  //
  //    return max(0, base * factor)
  //  }
}
