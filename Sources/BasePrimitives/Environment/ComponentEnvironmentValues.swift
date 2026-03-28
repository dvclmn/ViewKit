//
//  BaseEnvironmentValues.swift
//  Components
//
//  Created by Dave Coleman on 27/12/2024.
//

import SwiftUI

/// System-provided Env values for reference:
/// https://developer.apple.com/documentation/swiftui/environmentvalues/
/// Note: Many of the below are optional, allowing the caller
/// to provide a fallback meaningful to their domain.

// MARK: - Visuals
extension EnvironmentValues {
  
  /// This is primarily expected to represent the whole window of an app,
  /// minus any base UI components like Toolbar or Inspector.
  ///
  /// Useful as long as its companion modifier
  /// `viewportCapture(mode:showsIndicator:didUpdateSize)`
  /// is placed on the view the caller regards as the viewport area
  @Entry public var viewportRect: CGRect?

  /// I think this should be removed, and callers just access `viewportRect`
  /// directly and get the size from there
  public var viewportSize: CGSize? { viewportRect?.size }

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



// MARK: - Animation
extension EnvironmentValues {
  /// Important: For these binding env values, don't forget to actually
  /// initialise them somewhere in the app, to establish their source of truth
  @Entry public var isPaused: Binding<Bool> = .constant(true)
  @Entry public var frameRate: Binding<FrameRate> = .constant(.unlocked)
  @Entry public var animationClock: TimeInterval?
  @Entry public var isAnimationEnabled: Bool = false

}
