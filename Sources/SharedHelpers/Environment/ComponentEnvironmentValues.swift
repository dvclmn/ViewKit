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

  /// This originated from SumBuddy, where it was referred to
  /// as `characterSize`, derived from the width and height
  /// of a monospaced font glyph.
  ///
  /// Read more: ``UnitSize``
  @Entry public var unitSize: CGSize?
  @Entry public var gridDimensions: GridDimensions?

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

  /// This is primarily expected to represent the whole window of an app,
  /// minus any base UI components like Toolbar or Inspector.
  ///
  /// Useful as long as its companion modifier
  /// `viewportCapture(mode:showsIndicator:didUpdateSize)`
  /// is placed on the view the caller regards as the viewport area
  @Entry public var viewportSize: CGSize?
  @Entry public var viewportRect: CGRect?
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

  @Entry public var isInspectorPresented: Binding<Bool> = .constant(false)
  @Entry public var columnVisibility: Binding<NavigationSplitViewVisibility> = .constant(.automatic)

  @Entry public var isLoading: Bool = false

  /// From CanvasKit
  @Entry public var panOffset: CGSize = .zero
  @Entry public var zoomLevel: Double = 1.0
  @Entry public var zoomRange: ClosedRange<Double>?
  
  /// Note: This is already zoom-adjusted, so remains the same
  /// effective size regardless of zoom level
  @Entry public var canvasRounding: Double?

  /// Aka artwork size, document size
  @Entry public var canvasSize: CGSize?
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
