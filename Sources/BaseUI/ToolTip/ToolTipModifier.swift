//
//  ToolTip.swift
//  Eucalypt
//
//  Created by Dave Coleman on 3/3/2024.
//

import Foundation
import SharedHelpers
import SwiftUI

public struct Tooltip: ViewModifier {

  @State private var isHovered = false

  let text: String
  let offset: CGSize
  let alignment: Alignment
  let isShowingForDebug: Bool

  let colour: Color

  public func body(content: Content) -> some View {
    content
      .debouncedHover(enterInterval: 0.7, exitInterval: 0.2) { hovering in
        self.isHovered = hovering
      }  // END hover

      .overlay(alignment: toolTipAlignment) {

        TooTipView()

          .alignmentGuide(toolTipAlignment.horizontal) { d in

            /// Horizontal positioning
            switch toolTipAlignment.horizontal {
              case .leading:
                return d[.trailing] + totalOffset(for: .horizontal)  // Place tooltip to the left
              case .trailing:
                return d[.leading] + totalOffset(for: .horizontal)  // Place tooltip to the right
              default:  // center
                return d[HorizontalAlignment.center] + totalOffset(for: .horizontal)
            }
          }
          .alignmentGuide(toolTipAlignment.vertical) { d in
            /// Vertical positioning
            switch toolTipAlignment.vertical {
              case .top:
                return d[.bottom] + totalOffset(for: .vertical)  // Place tooltip above
              case .bottom:
                return d[.top] + totalOffset(for: .vertical)  // Place tooltip below
              default:  // center
                return d[VerticalAlignment.center] + totalOffset(for: .vertical)
            }
          }
          .allowsHitTesting(false)
        //                    .zIndex(999999)
        //                    .layoutPriority(10)
      }
    //    }
  }
}

extension Tooltip {

  private var toolTipAlignment: Alignment {
    alignment.forTooltip
  }

  private func totalOffset(for axis: Axis) -> CGFloat {
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
    //    let unitPoint = toolTipAlignment.toolTipUnitPoint
    let finalOffset = unitPoint.offset(by: totalOffset)
    return finalOffset[axis]

    //    let unitPoint = toolTipAlignment.toUnitPoint()
    //    guard unitPoint != .center else { return .zero }
    ////        let unitPoint = toolTipAlignment.toolTipUnitPoint
    //
    //    let finalOffset = unitPoint.offset(by: totalOffset)
    //    //      return .zero
    //    //    }
    //
    //
    //
    //    return finalOffset[axis]
    //    baseOffsetLength
  }

  //  private func totalOffset(for axis: Axis) -> CGFloat {
  //    return baseOffsetLength + offset[axis]
  //  }

  @ViewBuilder
  private func TooTipView() -> some View {

    if isHovered || isShowingForDebug {
      Text(text)
        .fixedSize(horizontal: true, vertical: false)
        .foregroundStyle(.primary.opacity(0.85))
        .font(.callout)
        .padding(.horizontal, Styles.sizeMicro)
        .padding(.vertical, Styles.sizeNano)
        .quickBackground(tint: colour)
    }
  }
}

extension View {
  public func tooltip(
    _ text: String,
    offset: CGSize = .zero,
    alignment: Alignment = .center,
    isShowingForDebug: Bool = false,
    color: Color = .black.opacity(0.6)
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
