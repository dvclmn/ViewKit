//
//  ButtonStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//

import CoreTools
import SwiftUI
import ViewTools

extension LabelStyle where Self == CustomLabel {
  public static var base: Self { Self() }

  /// If no value supplied for `display`, will use environment value, or fall back to `.titleAndIcon`
  public static func base(display: LabelDisplay?) -> Self { Self(labelDisplay: display) }

}

/// Note regarding `QuickLabel`: II think I need to handle this
/// once it's been composed into an actual `Label`
public struct CustomLabel: LabelStyle {
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.labelFontStyle) private var labelFontStyle
  @Environment(\.iconFontStyle) private var iconFontStyle
  @Environment(\.textAlignment) private var textAlignment

  let displayOverride: LabelDisplay?

  /// This allows the caller of `.labelStyle(.base)` to provide
  /// a labelDisplay 'then and there', rather than requiring an additional
  /// env value like `.environment(\.labelDisplay, .stacked)`
  public init(labelDisplay: LabelDisplay? = nil) {
    self.displayOverride = labelDisplay
  }

  public func makeBody(configuration: Configuration) -> some View {

    switch adjustedLabelDisplay {
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
        LabelBase(configuration)
          .labelsHidden()

      case .none:
        LabelBase(configuration)

    }  // END switch label display
  }
}

extension CustomLabel {

  private var adjustedLabelDisplay: LabelDisplay? {
    displayOverride ?? labelDisplay
  }

  @ViewBuilder
  private func IconView(_ configuration: Configuration) -> some View {
    if let iconFont {
      configuration.icon
        .font(iconFont)
    } else {
      configuration.icon
    }
//      .commonLabelStyles(for: .icon, displayOverride: adjustedLabelDisplay)
      
      
  }

  @ViewBuilder
  private func TitleView(_ configuration: Configuration) -> some View {
    configuration.title
      .commonLabelStyles(for: .title, displayOverride: adjustedLabelDisplay)
  }

  @ViewBuilder
  private func LabelBase(_ configuration: Configuration) -> some View {
    Label {
      TitleView(configuration)
    } icon: {
      IconView(configuration)

    }
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

  private var iconFont: Font? {
    guard let iconFontStyle else { return nil }
    return .system(iconFontStyle)
  }
}
