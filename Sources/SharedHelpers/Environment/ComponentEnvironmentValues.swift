//
//  BaseEnvironmentValues.swift
//  Components
//
//  Created by Dave Coleman on 27/12/2024.
//

import SwiftUI
import BasePrimitives

/// System-provided Env values for reference:
/// https://developer.apple.com/documentation/swiftui/environmentvalues/
/// Note: Many of the below are optional, allowing the caller
/// to provide a fallback meaningful to their domain.
extension EnvironmentValues {

  /// Icons
  @Entry public var iconColour: AnyShapeStyle? = nil
  @Entry public var iconWeight: Font.Weight? = nil
  @Entry public var iconFontSize: CGFloat? = nil

  /// Labels
  @Entry public var labelColour: AnyShapeStyle? = nil
  @Entry public var itemColour: Color? = nil
  @Entry public var labelWeight: Font.Weight? = nil
  
  
  /// This is useful because SwiftUI exposes control over display of
  /// icon and label elements in the form of the `LabelStyle` protocol.
  /// So when using custom label styles, setting e.g. `labelStyle(iconOnly)`
  /// will override the custom style. This works around that.
  @Entry public var labelDisplay: LabelDisplay? = nil
  
  
  /// Note: This is here because support for `labelsVisibility`
  /// is for macOS 15.0+ only
  @Entry public var labelHidden: Bool = false

  /// Strokes
  @Entry public var strokeColour: AnyShapeStyle? = nil
  @Entry public var strokeWeight: CGFloat? = nil
  
  @Entry public var isHovering: Bool = false

  /// See also system native values:
  /// `symbolRenderingMode` and `symbolVariants`

  /// The below exists because native `symbolVariants`
  /// is not optional, and it's useful to make these optional
  /// to provide per-View fallbacks

  /// An optional counterpart to native `symbolVariant`
  /// (note the plural), which is non-optional.
  //  @Entry public var symbolVariant: SymbolVariants? = nil

  /// As opposed to the above more *specific* naming such as icon{x},
  /// stroke{x}, these explicit{x} properties can be applied to anything.
  @Entry public var explicitSize: CGSize? = nil
  @Entry public var explicitHeight: CGFloat? = nil
  @Entry public var explicitWidth: CGFloat? = nil
  @Entry public var explicitFontSize: CGFloat? = nil

  /// Useful when referring to neither height nor width specifically
  @Entry public var explicitLength: CGFloat? = nil
  @Entry public var explicitRange: ClosedRange<CGFloat>? = nil

  /// Helpful article on `aspectRatio`
  /// https://alejandromp.com/development/blog/image-aspectratio-without-frames/
  /// See also `viewAspectRatio()` in BaseHelpers
  @Entry public var explicitAspectRatio: CGFloat? = nil
  @Entry public var explicitContentMode: ContentMode? = nil


  @Entry public var helpText: String = ""
  @Entry public var cornerRounding: CGFloat? = nil

  @Entry public var emphasisColour: AnyShapeStyle? = nil

  /// This (perhaps unneccesarily) pairs with `ContainerValue`
  /// of the same name, in BaseHelpers' Compatible collection.
  @Entry public var isShowingSectionHeader: Bool = true
  @Entry public var isBackgroundHidden: Bool = false

  /// Character columns here refers to a fixed number of characters
  /// (usually monospaced for consistency) in a horizontal line,
  /// usually for the purpose of achieving a predictable layout
  /// with working with varying character counts.
  /// See ``TextColumns`` for an example.
  @Entry public var maxCharacterColumns: Int = 5

  @Entry public var buttonRole: ButtonRole? = nil
  @Entry public var isFocusable: Bool = true
  @Entry public var isBackgroundExtensionEnabled: Bool = false
  @Entry public var isAnimationEnabled: Bool = false
  
  /// This originated from SumBuddy, where it was referred to
  /// as `characterSize`, derived from the width and height
  /// of a monospaced font glyph.
  ///
  /// Read more: ``UnitSize``
  @Entry public var unitSize: CGSize? = nil
  
  /// App-wide / project-wide mapping convention, for which
  /// property on a type should be considered the identity vs transposed.
  /// Aka whether width maps to horizontal, or rows to vertical, etc etc.
  /// See ``AxisAddressable``
  @Entry public var axisMapping: AxisMapping = .identity

  @Entry public var opacityDim: CGFloat? = nil
  
}
