//
//  ToolTip.swift
//  Eucalypt
//
//  Created by Dave Coleman on 3/3/2024.
//

import EnumMacros
import Foundation
import SharedHelpers
import SwiftUI

public struct Tooltip: ViewModifier {

  @State private var isHovered = false

  let text: String
  let offset: CGSize
  let alignment: Alignment
  let isShowingForDebug: Bool

  let colour: Color?

  public func body(content: Content) -> some View {
    content
      .debouncedHover(enterInterval: 0.4, exitInterval: 0.1) { hovering in
        withAnimation {
          self.isHovered = hovering
        }
      }  // END hover

//      .overlay(alignment: .toolTip) {
      .overlay(alignment: toolTipAlignment) {

        ToolTipView(
          text: text,
          isShowing: isShowing
        )
        .environment(\.itemColour, colour)
        

//        .alignmentGuide(toolTipAlignment.horizontal) { dimensions in
//          guidesH(dimensions)
//        }
//        .alignmentGuide(toolTipAlignment.vertical) { d in
//          /// Vertical positioning
//          switch toolTipAlignment.vertical {
//            case .top:
//              return d[.bottom] + totalOffset(for: .vertical)  // Place tooltip above
//            case .bottom:
//              return d[.top] + totalOffset(for: .vertical)  // Place tooltip below
//            default:  // center
//              return d[VerticalAlignment.center] + totalOffset(for: .vertical)
//          }
//        }
        .allowsHitTesting(false)

        //          .animation(Styles.animationEased, value: isShowing)
      }  // END overlay
  }
}

extension Tooltip {


  nonisolated private var toolTipAlignment: Alignment {
    alignment.forTooltip
  }



  private var isShowing: Bool { isHovered || isShowingForDebug }

}

extension View {
  public func tooltip(
    _ text: String,
    offset: CGSize = .zero,
    alignment: Alignment = .center,
    isShowingForDebug: Bool = false,
    color: Color? = nil
  ) -> some View {
    self.modifier(
      Tooltip(
        text: text,
        offset: offset,
        alignment: alignment,
        isShowingForDebug: isShowingForDebug,
        colour: color
      )
    )
  }
}
