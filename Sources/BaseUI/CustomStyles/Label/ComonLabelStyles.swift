//
//  CommonLabelModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/7/2025.
//

import CoreTools
import SwiftUI

public struct CommonLabelStyleModifier: ViewModifier {
  @Environment(\.labelWeight) private var labelWeight
  @Environment(\.labelColour) private var labelColour
  @Environment(\.iconWeight) private var iconWeight
  @Environment(\.iconColour) private var iconColour
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.labelFontStyle) private var labelFontStyle
  @Environment(\.labelTextCase) private var labelTextCase
  @Environment(\.labelFontSize) private var labelFontSize
  @Environment(\.symbolRenderingMode) private var symbolRenderingMode

  let part: LabelPart
  let displayOverride: LabelDisplay?
  public func body(content: Content) -> some View {
    Group {
      /// Handle if we've got a specific font for the Icon part
      ///
      /// Note: So far this modifier only handles Font, foreground style and font weight
      if let configuredFont {
        ConditionalColourView(content)
          .font(configuredFont)

      } else {
        ConditionalColourView(content)
      }
    }  // END group
    .fontWeight(part.weight(override: weightOverride))
    .textCase(labelTextCase)

  }
}
extension CommonLabelStyleModifier {

  @ViewBuilder
  private func ConditionalColourView(_ content: Content) -> some View {
    if let colourOverride {
      content
        .foregroundStyle(colourOverride)
    } else {
      content
    }
  }

  private var colourOverride: AnyShapeStyle? {
    if part.isIcon { return iconColour }
    if part.isTitle { return labelColour }
    return nil
  }

  private var weightOverride: Font.Weight? {
    if part.isIcon { return iconWeight }
    if part.isTitle { return labelWeight }
    return nil
  }

  private var configuredFont: Font? {

    /// Are we handling the icon part?
    //        guard part.isIcon else { return nil }
    //    if part.isTitle, let labelFontSize {
    //      return Font.system(size: labelFontSize)
    //    }

    if part.isTitle, let labelFontStyle {
      return Font.system(labelFontStyle)
    }

    /// (I think this is right?) We'll let any present `iconFontSize`
    /// value take precedence over whether the label display is
    /// stacked or not. This allows a fallback size for stacked,
    /// (as seen below, `Font.title2`), that can be overriden if needed.
    ///
    /// Note: No need (I think) for a title-specific property here,
    /// as it should just come from any specific font modifiers
    /// from outside?
    guard let iconFontSize else {
      return isStackedIcon ? Font.title2 : nil
    }
    return Font.system(size: iconFontSize)
  }

  private var internalLabelDisplay: LabelDisplay? {
    displayOverride ?? labelDisplay
  }

  private var isStackedIcon: Bool {
    let isStacked: Bool = internalLabelDisplay?.isStacked ?? false
    return isStacked && part.isIcon
  }

}
extension View {
  public func commonLabelStyles(
    for labelPart: LabelPart,
    displayOverride: LabelDisplay?
  ) -> some View {
    self.modifier(
      CommonLabelStyleModifier(
        part: labelPart,
        displayOverride: displayOverride
      )
    )
  }
}
