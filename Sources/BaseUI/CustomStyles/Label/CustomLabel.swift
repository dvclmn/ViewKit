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

  @available(*, deprecated, renamed: "base", message: "Prefer more accurately named 'base'.")
  public static var custom: Self { Self() }
}

/// Note regarding `MaybeLabel`: II think I need to handle this
/// once it's been composed into an actual `Label`
public struct CustomLabel: LabelStyle {
  @Environment(\.labelDisplay) private var labelDisplay
  @Environment(\.isCompactMode) private var isCompactMode
  @Environment(\.layoutSpacing) private var layoutSpacing
  @Environment(\.layoutAlignment) private var layoutAlignment
  @Environment(\.textAlignment) private var textAlignment

  let explicitLabelDisplay: LabelDisplay?

  /// This allows the caller of `.labelStyle(.base)` to provide
  /// a labelDisplay 'then and there', rather than requiring an additional
  /// env value like `.environment(\.labelDisplay, .stacked)`
  public init(labelDisplay: LabelDisplay? = nil) {
    self.explicitLabelDisplay = labelDisplay
  }

  public func makeBody(configuration: Configuration) -> some View {

    switch internalLabelDisplay {
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
        /// Note: Opted to define stacked within `CustomButton`,
        /// rather than it's own seperate `LabelStyle`, as things were
        /// starting to get a bit circular / self-referential or something
        VStack(
          alignment: layoutAlignment?.horizontal ?? .center,
          spacing: layoutSpacing ?? Styles.sizeSmall
        ) {
          configuration.title
            .commonLabelStyles(for: .title, display: internalLabelDisplay)

            .overlay {
              configuration.icon
                .commonLabelStyles(for: .icon, display: internalLabelDisplay)
              //                .aspectRatio(1, contentMode: .fill)

            }
        }

      case .hidden:
        LabelBase(configuration)
          .labelsHidden()

      case .none:
        LabelBase(configuration)

    }  // END switch label display
  }
}

extension CustomLabel {

  private var internalLabelDisplay: LabelDisplay? {
    explicitLabelDisplay ?? labelDisplay
  }

  @ViewBuilder
  private func LabelBase(_ configuration: Configuration) -> some View {
    Label {
      configuration.title
        .commonLabelStyles(for: .title, display: internalLabelDisplay)
    } icon: {
      configuration.icon
        .commonLabelStyles(for: .icon, display: internalLabelDisplay)
    }
  }
}

extension VerticalAlignment {
  /// A custom alignment for image titles.
  private struct ImageTitleAlignment: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
      // Default to bottom alignment if no guides are set.
      context[VerticalAlignment.bottom]
    }
  }

  /// A guide for aligning titles.
  static let imageTitleAlignmentGuide = VerticalAlignment(
    ImageTitleAlignment.self
  )
}
