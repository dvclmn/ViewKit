//
//  ColourHandler.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI


//public struct ColourHandler: ColourHandlerProtocol, Sendable {
//
//  /// This describes which colour is currently being used for drawing
//  public var activeColourLevel: HierarchicalColour = .primary
//  /// This is when a user directly clicks a colour, and is editing it
//  public var focusedColourLevel: HierarchicalColour? = nil
//  public var hoveredColourLevel: HierarchicalColour? = nil
//
//  /// This is the current, user-selected colour (there may be another
//  /// introduced, so becoming foreground and background).
//  public var foregroundRGB: RGBColour = .brown
//  public var backgroundRGB: RGBColour = .orange
//
//  public init() {}
//  /// When changing HSV, update the canonical RGBA
//  //  func update(fromHSV hsv: HSVColour) {
//  //    let result = RGBColour(fromHSV: hsv)
//  //    self.linearRGBA = result
//  //  }
//
//}
//
////
//extension ColourHandler {
//
//  //  public func rgbSwiftUIColour(for level: ColourLevel) -> Color {
//  //    switch level {
//  //      case .foreground: foregroundRGB.swiftUIColour
//  //      case .background: backgroundRGB.swiftUIColour
//  //    }
//  //  }
//  //  public func contrastingSwiftUIColour(
//  //    for level: ColourLevel,
//  //    withPreset preset: ContrastPreset = .standard,
//  //  ) -> Color {
//  //    switch level {
//  //      case .foreground: foregroundRGB.contrastColour(withPreset: preset).swiftUIColour
//  //      case .background: backgroundRGB.contrastColour(withPreset: preset).swiftUIColour
//  //    }
//  //  }
//
//  //  public func isShowingSwappable(_ isHovering: Bool) -> Bool {
//  //    isHovering && modifierKeys.contains(.option)
//  //  }
//
//  public var selectedColourBorderBrightness: ColourBorderBrightness {
//    return ColourBorderBrightness(from: selectedColour.luminance())
//  }
//
//  public var foreground: Color {
//    foregroundRGB.toColour
//  }
//  public var background: Color {
//    backgroundRGB.toColour
//  }
//  //  public var foregroundHSV: HSVColour {
//  //    HSVColour(fromRGB: foregroundRGB)
//  //  }
//  //  public var backgroundHSV: HSVColour {
//  //    HSVColour(fromRGB: backgroundRGB)
//  //  }
//
//  public var selectedColour: RGBColour {
//    switch activeColourLevel {
//      case .primary:
//        return foregroundRGB
//      case .secondary:
//        return backgroundRGB
//    }
//  }
//
//  public mutating func swapColours() {
//    activeColourLevel.next()
//  }
//}
