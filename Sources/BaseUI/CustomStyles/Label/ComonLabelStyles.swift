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
  @Environment(\.iconWeight) private var iconWeight
  @Environment(\.iconColour) private var iconColour
  @Environment(\.iconFontSize) private var iconFontSize
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.symbolRenderingMode) private var symbolRenderingMode

  let labelPart: LabelPart
  let explicitLabelDisplay: LabelDisplay?
  public func body(content: Content) -> some View {
    Group {
      /// Handle if we've got a specific font for the Icon part
      if let finalIconFont {
        content
          .font(finalIconFont)

      } else {
        content
      }
    }  // END group
    /// This and the below `symbolRenderingMode` are mucking with
    /// the control I have over render modes out in the view using MayBae Label
//    .foregroundStyle(labelPart.isIcon ? finalIconStyle : AnyShapeStyle(.primary))
    .fontWeight(elementWeight)

    /// Note: Choosing not to set `.symbolVariant()` here. Prefer setting this high
    /// up in the View hierarchy, and overriding with `.environment(_:_:)`.
    /// This saves needing a shadow `symbolVariant` Env value
//    .symbolRenderingMode(symbolRenderingMode ?? .hierarchical)

  }
}
extension CommonLabelStyleModifier {

  private var finalIconFont: Font? {

    /// Are we handling the icon part?
    guard labelPart.isIcon else { return nil }

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

  private var finalIconStyle: AnyShapeStyle {
    iconColour ?? AnyShapeStyle(.secondary)
  }

  private var internalLabelDisplay: LabelDisplay? {
    explicitLabelDisplay ?? labelDisplay
  }

  private var isStackedIcon: Bool {
    let isStacked: Bool = internalLabelDisplay?.isStacked ?? false
    return isStacked && labelPart.isIcon
  }

  var elementWeight: Font.Weight? {
    switch labelPart {
      case .title:
        return labelWeight
      case .icon:
        return iconWeight ?? .semibold
    }
  }

}
extension View {
  public func commonLabelStyles(
    for labelPart: LabelPart,
    display: LabelDisplay?
  ) -> some View {
    self.modifier(
      CommonLabelStyleModifier(
        labelPart: labelPart,
        explicitLabelDisplay: display
      )
    )
  }
}

@CaseDetection
public enum LabelPart {
  case title
  case icon
}
