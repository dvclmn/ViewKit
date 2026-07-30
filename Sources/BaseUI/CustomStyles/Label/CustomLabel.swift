//
//  ButtonStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//

import CoreTools
import SwiftUI
import ViewTools

public struct CustomLabel: LabelStyle {
  // General
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.labelTextCase) private var labelTextCase
  @Environment(\.textAlignment) private var textAlignment

  // Label Title
//  @Environment(\.labelTitleColour) private var labelTitleColour
  @Environment(\.labelTitleWeight) private var labelTitleWeight
  @Environment(\.labelTitleFontStyle) private var labelTitleFontStyle

  // Label Icon
  @Environment(\.labelIconColour) private var labelIconColour
  @Environment(\.labelIconWeight) private var labelIconWeight
  @Environment(\.labelIconFontStyle) private var labelIconFontStyle
  //  @Environment(\.labelIconFontStyle) private var labelIconFontStyle

  let displayOverride: LabelDisplay?

  // This allows the caller of `.labelStyle(.base)` to provide
  // a labelDisplay 'then and there' in the function signature,
  // rather than requiring an additional call to an env value
  // like `.environment(\.labelDisplay, .stacked)`
  public init(labelDisplay: LabelDisplay? = nil) {
    self.displayOverride = labelDisplay
  }

  public func makeBody(configuration: Configuration) -> some View {

    switch effectiveLabelDisplay {
      case .iconOnly:
        LabelBase(configuration)
          .labelStyle(.iconOnly)

      case .titleOnly:
        LabelBase(configuration)
          .labelStyle(.titleOnly)

      case .titleAndIcon:
        LabelBase(configuration)
          .labelStyle(.titleAndIcon)

      case .stacked:
        // Note: `stacked` is the only `LabelDisplay` that
        // doesn't use `LabelBase`
        Stacked(configuration)

      case .hidden:
        // Still working out what to do for this case
        LabelBase(configuration)
    //        EmptyView()

    //          .labelsHidden()

    }  // END switch label display
  }
}

extension CustomLabel {

  private var effectiveLabelDisplay: LabelDisplay {
    displayOverride ?? labelDisplay ?? .titleAndIcon
  }

  @ViewBuilder
  private func LabelBase(_ configuration: Configuration) -> some View {
    Label {
      TitleView(configuration)
    } icon: {
      IconView(configuration)
    }
    .textCase(labelTextCase)
  }

  @ViewBuilder
  private func TitleView(_ configuration: Configuration) -> some View {
    configuration.title
      .font(labelTitleFontStyle)
      .fontWeight(labelTitleWeight)
    //      .commonLabelStyles(for: .title, displayOverride: adjustedLabelDisplay)
  }

  @ViewBuilder
  private func IconView(_ configuration: Configuration) -> some View {
    //    if let iconFont {
    configuration.icon
      .font(labelIconFontStyle)
      .fontWeight(labelIconWeight)
      .tint(labelIconColour)
    //    } else {
    //      configuration.icon
    //    }
    //      .commonLabelStyles(for: .icon, displayOverride: adjustedLabelDisplay)

  }

  @ViewBuilder
  private func Stacked(_ configuration: Configuration) -> some View {
    VStack(
      alignment: layoutAlignment?.horizontal ?? .center,
      spacing: layoutSpacing ?? Styles.sizeSmall,
    ) {
      IconView(configuration)
      TitleView(configuration)
    }

  }

  //  private var iconFont: Font? {
  //    guard let iconFontStyle else { return nil }
  //    return .system(iconFontStyle)
  //  }
}
