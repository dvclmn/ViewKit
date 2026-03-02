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

// MARK: - Visuals
extension EnvironmentValues {
  /// Strokes
  @Entry public var strokeColour: AnyShapeStyle?
  @Entry public var strokeWeight: CGFloat?
  @Entry public var emphasisShapeStyle: AnyShapeStyle?
  @Entry public var emphasisColour: Color?
  @Entry public var colourIntensity: Double?
  @Entry public var opacityDim: CGFloat?

  @Entry public var cornerRounding: CGFloat?

  /// Relating to SwiftUI's `backgroundExtensionEffect()` modifier
  @Entry public var isBackgroundExtensionEnabled: Bool = false
  @Entry public var hasGlassEffect: Bool = false

}

extension EnvironmentValues {

  @Entry public var isHovering: Bool = false

  @Entry public var buttonRole: ButtonRole?
  @Entry public var isFocusable: Bool = true

  /// Meant as a debug helper, for when I'm not sure who is
  /// consuming this View, or what it's context is.
  @Entry public var viewDescription: String?
  @Entry public var helpText: String = ""

  @Entry public var isScrollAtStart: Bool = true

  @Entry public var isInspectorPresented: Binding<Bool> = .constant(false)
  @Entry public var columnVisibility: Binding<NavigationSplitViewVisibility> = .constant(.automatic)

  @Entry public var isLoading: Bool = false
  
  //  @Entry public var viewModes: ViewModes = []
  /// note: The below is not currently true, but may be the case
  /// once I figure out usage of ``ViewModes`` better
  /// ~~Below are aliases for `viewModes.contains(.debug)`.
  /// Prefer `viewModes` for new code.~~
  
  @Entry public var isDebugMode: Bool = false
  @Entry public var isEmphasised: Bool = false
  
  /// Note: `isCompactMode` is handy to have, for basic on/off
  /// declaration, but at times more granular view sizing control is needed,
  /// so prefer use of native `controlSize` in those cases/
  @Entry public var isCompactMode: Bool = false
  @Entry public var isEditable: Bool = true

}

// MARK: - Value formatting
extension EnvironmentValues {

  @Entry public var formatValue: (Double) -> String = { $0.displayString }

  /// E.g. 3 places: `10.056` or one place: `10.1`
  /// See `Foundation/NumberFormatStyleConfiguration/Precision`
  /// This imposes a fixed number (no min or max) of places.
  @Entry public var fractionLength: Int?

  /// E.g. 3 places: `023.6` or two places: `23.6`
  /// As implied in the name, this won't impose an upper limit,
  /// only ensure there are at least 'x' integers
  @Entry public var minIntegerLength: Int?

  /// App-wide / project-wide mapping convention, for which
  /// property on a type should be considered the identity vs transposed.
  /// Aka whether width maps to horizontal, or rows to vertical, etc etc.
  /// See ``AxisAddressable``
  @Entry public var axisMapping: AxisMapping = .identity

}

public protocol ValueFormattable {}
extension View where Self: ValueFormattable {
  public func formatValue(_ format: @escaping (Double) -> String) -> some View {
    self.environment(\.formatValue, format)
  }
}

// MARK: - Animation
extension EnvironmentValues {
  /// Important: For these binding env values, don't forget to actually
  /// initialise them somewhere in the app, to establish their source of truth
  @Entry public var isPaused: Binding<Bool> = .constant(true)
  @Entry public var frameRate: Binding<FrameRate> = .constant(.unlocked)
  @Entry public var animationClock: TimeInterval?
  @Entry public var isAnimationEnabled: Bool = false

}
