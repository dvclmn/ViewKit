//
//  ToolTip.swift
//  Eucalypt
//
//  Created by Dave Coleman on 3/3/2024.
//

import EnumMacros
import Foundation
import BasePrimitives
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
        .backgroundTint(colour)
//        .environment(\.explicitColour, colour)
//        .offset(alignment.offset(distance: 10, radial: .outward))

        
        .alignmentGuide(toolTipAlignment.horizontal) { dimensions in
          dimensions.offset(
            for: toolTipAlignment,
            axis: .horizontal,
            magnitude: 1.2,
            radial: .outward
          )
        }
        
        .alignmentGuide(toolTipAlignment.vertical) { dimensions in
          dimensions.offset(
            for: toolTipAlignment,
            axis: .vertical,
            magnitude: 1.2,
            radial: .outward
          )
        }
//          /// Horizontal positioning
//          switch toolTipAlignment.horizontal {
//            case .leading:
//              return d[.trailing] + totalOffset(for: .horizontal)  // Place tooltip to the left
//            case .trailing:
//              return d[.leading] + totalOffset(for: .horizontal)  // Place tooltip to the right
//            default:  // center
//              return d[HorizontalAlignment.center] + totalOffset(for: .horizontal)
//          }
//          //          guidesH(dimensions)
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

//  private func alignmentOffset(for axis: Axis2D, dimensions: ViewDimensions) -> CGFloat {
//    let length = axis.isHorizontal ? dimensions.width : dimensions.height
//    
//    let offsetMagnitude = length * 0.2
//    let offset = alignment.offset(distance: offsetMagnitude, radial: .outward)
//    return dimensions[alignment] + offset
////    let offset: CGFloat = {
////      switch alignment {
////        case .leading: .zero
////        case .trailing: .zero
////        default: .zero
////      }
////    }()
//  }

  nonisolated private var toolTipAlignment: Alignment {
    alignment.forTooltip
  }

  nonisolated private func totalOffset(
    for axis: Axis2D,
    viewSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGFloat {
    /// Note: The below `defaultOffset` bakes in a
    /// slight horizontal inset, just as it felt more pleasing.
    /// This excludes `leading` and `trailing`, where the inset
    /// would cause overlap with the content.

    let excludedAlignments: [Alignment] = [.leading, .trailing]
    let hasInset: Bool = !excludedAlignments.contains(toolTipAlignment)
    let insetH: CGFloat = hasInset ? -14 : 12

    let defaultOffset = CGSize(insetH, 10)
    let totalOffset: CGSize = defaultOffset

    let unitPoint = toolTipAlignment.toUnitPoint()

    let finalOffset = unitPoint.offset(by: totalOffset)
    return finalOffset.value(along: axis, mapping: mapping)

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
