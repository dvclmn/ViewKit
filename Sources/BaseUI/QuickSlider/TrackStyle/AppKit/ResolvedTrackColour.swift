//
//  ResolvedTrackColour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit
import SwiftUI

public struct ResolvedTrackColour: Equatable, Sendable {
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double
  
  public init(
    red: Double,
    green: Double,
    blue: Double,
    alpha: Double = 1.0,
  ) {
    self.red = red.clampedToUnit
    self.green = green.clampedToUnit
    self.blue = blue.clampedToUnit
    self.alpha = alpha.clampedToUnit
  }
}

// MARK: - Convenience inits
extension ResolvedTrackColour {
  public init(
    white: Double,
    alpha: Double = 1.0,
  ) {
    self.init(red: white, green: white, blue: white, alpha: alpha)
  }
  
  public init(
    hue: Double,
    saturation: Double,
    brightness: Double,
    alpha: Double = 1.0,
  ) {
    self.init(
      NSColor(
        calibratedHue: CGFloat(hue.clampedToUnit),
        saturation: CGFloat(saturation.clampedToUnit),
        brightness: CGFloat(brightness.clampedToUnit),
        alpha: CGFloat(alpha.clampedToUnit),
      )
    )
  }
  
  public init(_ colour: Color) {
    self.init(NSColor(colour))
  }
  
  public init(_ colour: NSColor) {
    let converted = colour.usingColorSpace(.sRGB) ?? colour
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0
    
    converted.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
    self.init(
      red: Double(red),
      green: Double(green),
      blue: Double(blue),
      alpha: Double(alpha),
    )
  }
  
  public func withAlpha(_ alpha: Double) -> Self {
    Self(red: red, green: green, blue: blue, alpha: alpha)
  }
}

extension ResolvedTrackColour {
  public static let black = Self(white: 0.0)
  public static let white = Self(white: 1.0)
  public static let clear = Self(white: 0.0, alpha: 0.0)
  public static let grey = Self(white: 0.5)
}

extension ResolvedTrackColour {
  var nsColour: NSColor {
    NSColor(
      calibratedRed: CGFloat(red),
      green: CGFloat(green),
      blue: CGFloat(blue),
      alpha: CGFloat(alpha),
    )
  }
  
  var cgColour: CGColor {
    CGColor(
      red: CGFloat(red),
      green: CGFloat(green),
      blue: CGFloat(blue),
      alpha: CGFloat(alpha),
    )
  }
}


extension Double {
  fileprivate var clampedToUnit: Double {
    min(max(self, 0.0), 1.0)
  }
}

#endif
