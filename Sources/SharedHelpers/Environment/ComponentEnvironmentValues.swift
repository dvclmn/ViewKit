//
//  BaseEnvironmentValues.swift
//  Components
//
//  Created by Dave Coleman on 27/12/2024.
//

import BasePrimitives
import SwiftUI

/// System-provided Env values for reference:
/// https://developer.apple.com/documentation/swiftui/environmentvalues/
/// Note: Many of the below are optional, allowing the caller
/// to provide a fallback meaningful to their domain.
extension EnvironmentValues {

  /// Note: This is here because support for `labelsVisibility`
  /// is for macOS 15.0+ only
  /// Update: Have removed in favour of adding `hidden`
  /// case to ``LabelDisplay``
  //  @Entry public var labelHidden: Bool = false

  /// Strokes
  @Entry public var strokeColour: AnyShapeStyle? = nil
  @Entry public var strokeWeight: CGFloat? = nil

  // MARK: - Sizing overrides
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
  @Entry public var explicitControlSize: ControlSize? = nil

  @Entry public var helpText: String = ""
  @Entry public var cornerRounding: CGFloat? = nil

  /// Perhaps the below two can be merged.
  @Entry public var explicitColour: AnyShapeStyle? = nil
  //  @Entry public var explicitColour: (any ShapeStyle)? = nil
  @Entry public var emphasisColour: AnyShapeStyle? = nil

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
  @Entry public var gridDimensions: GridDimensions? = nil

  /// App-wide / project-wide mapping convention, for which
  /// property on a type should be considered the identity vs transposed.
  /// Aka whether width maps to horizontal, or rows to vertical, etc etc.
  /// See ``AxisAddressable``
  @Entry public var axisMapping: AxisMapping = .identity

  @Entry public var opacityDim: CGFloat? = nil
  @Entry public var isHovering: Bool = false

  /// Meant as a debug helper, for when I'm not sure who is
  /// consuming this View, or what it's context is.
  @Entry public var viewDescription: String? = nil

  /// This is primarily expected to represent the whole window of an app,
  /// minus any base UI components like Toolbar or Inspector.
  ///
  /// I guess like in a graphics app, so maybe this is a bit domain-specific
  @Entry public var viewportSize: CGSize? = nil
  @Entry public var isScrollAtStart: Bool = true

  @Entry public var formatValue: (Double) -> String = { $0.displayString }
}

public protocol ValueFormattable {}

extension View where Self: ValueFormattable {
  public func formatValue(_ format: @escaping (Double) -> String) -> some View {
    self.environment(\.formatValue, format)
  }
}

extension View {
  public func setGridDimensions(_ width: Int, height: Int) -> some View {
    self.environment(\.gridDimensions, GridDimensions(width, height))
  }
}
