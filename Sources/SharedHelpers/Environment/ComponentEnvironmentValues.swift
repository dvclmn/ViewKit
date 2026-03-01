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
  @Entry public var strokeColour: AnyShapeStyle?
  @Entry public var strokeWeight: CGFloat?

  // MARK: - Overrides
  /// As opposed to the above more *specific* naming such as icon{x},
  /// stroke{x}, these override{x} properties can be applied to anything.
  @Entry public var sizeOverride: CGSize?
  @Entry public var heightOverride: CGFloat?
  @Entry public var widthOverride: CGFloat?
  @Entry public var fontSizeOverride: CGFloat?
  @Entry public var fontWeightOverride: Font.Weight?

  /// `length` useful when referring to neither height nor width specifically
  @Entry public var lengthOverride: CGFloat?
  @Entry public var rangeOverride: ClosedRange<CGFloat>?

  /// Helpful article on `aspectRatio`
  /// https://alejandromp.com/development/blog/image-aspectratio-without-frames/
  /// See also `viewAspectRatio()` in BaseHelpers
  @Entry public var aspectRatioOverride: CGFloat?
  @Entry public var contentModeOverride: ContentMode?
  @Entry public var controlSizeOverride: ControlSize?

  @Entry public var helpText: String = ""
  @Entry public var cornerRounding: CGFloat?

  /// Perhaps the below two can be merged.
  @Entry public var shapeStyleOverride: AnyShapeStyle?
  @Entry public var colourOverride: Color?
  @Entry public var emphasisShapeStyle: AnyShapeStyle?
  @Entry public var emphasisColour: Color?

  @Entry public var colourIntensity: Double?

  @Entry public var buttonRole: ButtonRole?
  @Entry public var isFocusable: Bool = true
  @Entry public var isBackgroundExtensionEnabled: Bool = false

  /// App-wide / project-wide mapping convention, for which
  /// property on a type should be considered the identity vs transposed.
  /// Aka whether width maps to horizontal, or rows to vertical, etc etc.
  /// See ``AxisAddressable``
  @Entry public var axisMapping: AxisMapping = .identity

  @Entry public var opacityDim: CGFloat?
  @Entry public var isHovering: Bool = false

  /// Meant as a debug helper, for when I'm not sure who is
  /// consuming this View, or what it's context is.
  @Entry public var viewDescription: String?

  @Entry public var isScrollAtStart: Bool = true

  @Entry public var formatValue: (Double) -> String = { $0.displayString }

  /// E.g. 3 places: `10.056` or one place: `10.1`
  /// See `Foundation/NumberFormatStyleConfiguration/Precision`
  /// This imposes a fixed number (no min or max) of places.
  @Entry public var fractionLength: Int?

  /// E.g. 3 places: `023.6` or two places: `23.6`
  /// As implied in the name, this won't impose an upper limit,
  /// only ensure there are at least 'x' integers
  @Entry public var minIntegerLength: Int?

  /// Important: For these binding env values, don't forget to actually
  /// initialise them somewhere in the app, to establish their source of truth
  @Entry public var isPaused: Binding<Bool> = .constant(true)
  @Entry public var frameRate: Binding<FrameRate> = .constant(.unlocked)
  @Entry public var animationClock: TimeInterval?
  @Entry public var isAnimationEnabled: Bool = false

  @Entry public var hasGlassEffect: Bool = false

  /// This is directly related to `gridFont` and `canvasBaseFontSize`
  @Entry public var unitSize: CGSize?
  @Entry public var gridDimensions: GridDimensions?
  @Entry public var gridFont: GridFont?

  @Entry public var isASCIIMode: Bool = false
  @Entry public var canvasBaseFontSize: CGFloat?
  @Entry public var asciiModeFontSize: CGFloat?
  //  @Entry public var characterDimensions: CharacterDimensions?
  //  @Entry public var asciiUnitSize: CGSize?

  /// Scale ratio from canvas font size domain to ASCII mode font size domain.
  /// Example: canvas 28pt and ASCII 14pt gives a scale of 0.5.
  public var asciiScaleRelativeToCanvas: CGFloat? {
    guard
      let asciiModeFontSize,
      let canvasBaseFontSize,
      asciiModeFontSize.isFinite,
      canvasBaseFontSize.isFinite,
      asciiModeFontSize > 0,
      canvasBaseFontSize > 0
    else { return nil }

    return asciiModeFontSize / canvasBaseFontSize
  }

  /// Derived cell size for ASCII UI mode.
  ///
  /// This relies on `CharacterSizeModifier` providing `unitSize` with a value
  /// in an ancestor view, where `unitSize` is measured at `canvasBaseFontSize`.
  public var asciiUnitSize: CGSize? {
    guard let unitSize, let scale = asciiScaleRelativeToCanvas else { return nil }
    return unitSize * scale
  }

  /// Current effective unit size for the active domain.
  public var activeUnitSize: CGSize? {
    if isASCIIMode {
      return asciiUnitSize ?? unitSize
    }
    return unitSize
  }

  @Entry public var isInspectorPresented: Binding<Bool> = .constant(false)
  @Entry public var columnVisibility: Binding<NavigationSplitViewVisibility> = .constant(.automatic)

  @Entry public var isLoading: Bool = false

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
