//
//  ToolTip.swift
//  Eucalypt
//
//  Created by Dave Coleman on 3/3/2024.
import CoreTools
import ViewTools
//import InteractionKit
import EnumMacros
import Foundation
import SwiftUI

public struct ToolTipModifier: ViewModifier {

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

      .overlay(alignment: toolTipAlignment) {

        ToolTipView(
          text: text,
          isShowing: isShowing
        )
        .backgroundTint(colour)

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
        .allowsHitTesting(false)
      }  // END overlay
  }
}

extension ToolTipModifier {

  nonisolated private var toolTipAlignment: Alignment {
    alignment.forTooltip
  }

  nonisolated private func totalOffset(
    for axis: GeometryAxis,
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

    let defaultOffset = CGSize(width: insetH, height: 10)
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
      ToolTipModifier(
        text: text,
        offset: offset,
        alignment: alignment,
        isShowingForDebug: isShowingForDebug,
        colour: color
      )
    )
  }
}
