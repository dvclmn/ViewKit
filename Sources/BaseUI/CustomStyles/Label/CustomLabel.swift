//
//  ButtonStyle.swift
//  Styles
//
//  Created by Dave Coleman on 30/4/2024.
//

import CoreTools
import SwiftUI

extension LabelStyle where Self == CustomLabel {
  public static var base: Self { Self() }

  /// If no value supplied for `display`, will use environment value, or fall back to `.titleAndIcon`
  public static func base(display: LabelDisplay?) -> Self { Self(labelDisplay: display) }

}

/// Note regarding `MaybeLabel`: II think I need to handle this
/// once it's been composed into an actual `Label`
public struct CustomLabel: LabelStyle {
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.labelFontStyle) private var labelFontStyle
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
        /// Note: Only `LabelDisplay` that doesn't use `LabelBase`
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
  private func LabelBase(_ configuration: Configuration) -> some View {
    Label {
      configuration.title
        .commonLabelStyles(for: .title, displayOverride: adjustedLabelDisplay)
    } icon: {
      configuration.icon
        .commonLabelStyles(for: .icon, displayOverride: adjustedLabelDisplay)
    }
  }

  @ViewBuilder
  private func Stacked(_ configuration: Configuration) -> some View {
    VStack(
      alignment: layoutAlignment?.horizontal ?? .center,
      spacing: layoutSpacing ?? Styles.sizeSmall
    ) {
      configuration.icon
        .commonLabelStyles(for: .icon, displayOverride: adjustedLabelDisplay)

      configuration.title
        .commonLabelStyles(for: .title, displayOverride: adjustedLabelDisplay)
    }
  }

}

//extension VerticalAlignment {
//  /// A custom alignment for image titles.
//  private struct ImageTitleAlignment: AlignmentID {
//    static func defaultValue(in context: ViewDimensions) -> CGFloat {
//      /// Default to bottom alignment if no guides are set.
//      context[VerticalAlignment.bottom]
//    }
//  }
//
//  /// A guide for aligning titles.
//  static let imageTitleAlignmentGuide = VerticalAlignment(
//    ImageTitleAlignment.self
//  )
//}
