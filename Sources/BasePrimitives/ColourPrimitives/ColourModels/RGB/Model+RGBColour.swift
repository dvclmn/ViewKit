//
//  Model+RGB.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI

public struct RGBColour: Identifiable, Equatable, Hashable, Sendable, Codable,
  ColourModel
{
  public let id: UUID
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double

  public var name: String?

  /// 8-bit integers (0–255)
  public let is255: Bool

  /// Values are expected to be normalised
  // TODO: Add check for 0-255 vs normalised [0-1] values
  public init(
    red: Double,
    green: Double,
    blue: Double,
    is255: Bool = false,
    alpha: Double = 1.0,
    name: String? = nil
  ) {
    self.id = UUID()
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
    self.name = name
    self.is255 = is255
  }
}
// MARK: - Initialisers
extension RGBColour: _ExpressibleByColorLiteral {
  public init(
    _colorLiteralRed red: Float,
    green: Float,
    blue: Float,
    alpha: Float
  ) {
    self.init(
      red: Double(red),
      green: Double(green),
      blue: Double(blue),
      alpha: Double(alpha),
      name: nil
    )
  }

  public var toColour: Color {
    Color(
      colourSpace,
      red: red,
      green: green,
      blue: blue,
      opacity: alpha
    )
  }
}

extension RGBColour {
  // To suit Color literals
  // #colorLiteral(red: 1, green: 0.5273173451, blue: 1, alpha: 1)
  //  public init?(
  //    _ cgColor: CGColor,
  //  ) {
  //    /// Try to ensure we are working in an RGB-compatible color space
  //    let rgbColor: CGColor
  //    if let cs = cgColor.colorSpace, cs.model == .rgb {
  //      rgbColor = cgColor
  //    } else if let converted = cgColor.converted(to: CGColorSpace(name: CGColorSpace.sRGB)!, intent: .defaultIntent, options: nil) {
  //      rgbColor = converted
  //    } else {
  //      /// As a last resort, try to read components anyway (may be grayscale, etc.)
  //      rgbColor = cgColor
  //    }
  //
  //    guard let components = rgbColor.components else { return nil }
  //
  //    let model = rgbColor.colorSpace?.model
  //
  //    let rCGFloat: CGFloat
  //    let gCGFloat: CGFloat
  //    let bCGFloat: CGFloat
  //    let aCGFloat: CGFloat
  //
  //    switch model {
  //    case .some(.rgb):
  //      // Expect 3 (RGB) or 4 (RGBA) components
  //      guard components.count >= 3 else { return nil }
  //      rCGFloat = components[0]
  //      gCGFloat = components[1]
  //      bCGFloat = components[2]
  //      aCGFloat = components.count >= 4 ? components[3] : rgbColor.alpha
  //
  //    case .some(.monochrome):
  //      /// Grayscale color spaces provide one component (white), plus optional alpha
  //      guard let white = components.first else { return nil }
  //      rCGFloat = white
  //      gCGFloat = white
  //      bCGFloat = white
  //      aCGFloat = components.count >= 2 ? components[1] : rgbColor.alpha
  //
  //    default:
  //      /// Unsupported color model for our simple RGB extraction
  //      return nil
  //    }
  //
  //    self.init(
  //      red: Double(rCGFloat),
  //      green: Double(gCGFloat),
  //      blue: Double(bCGFloat),
  //      alpha: Double(aCGFloat),
  //      name: nil
  //    )
  //  }

  public init(
    r: Double,
    g: Double,
    b: Double,
    a: Double = 1.0,
    name: String? = nil,
  ) {
    self.init(red: r, green: g, blue: b, alpha: a, name: name)
  }

  public init(
    _ r: Double,
    _ g: Double,
    _ b: Double,
    a: Double = 1.0,
    name: String? = nil
  ) {
    self.init(red: r, green: g, blue: b, alpha: a, name: name)
  }

  public init(
    fromSystem system: SystemColour,
    env: EnvironmentValues
  ) {
    self.init(
      colour: system.toColour,
      environment: env,
      name: system.name
    )
  }
}

extension RGBColour {

  public var toOpaque: Self {
    RGBColour(red, green, blue, a: 1.0, name: name)
  }

  public var areAllComponentsNormalised: Bool {
    red.isWithin(.unitRange)
      && green.isWithin(.unitRange)
      && blue.isWithin(.unitRange)
  }

  public static func from255(
    _ r: Int,
    _ g: Int,
    _ b: Int,
    name: String? = nil
  ) -> RGBColour {
    self.init(
      red: Double(r / 255),
      green: Double(g / 255),
      blue: Double(b / 255),
      is255: true,
      alpha: 1.0,
      name: name
    )
  }

  /// Create a color with specified brightness (0.0 to 1.0)
  public static func gray(
    _ brightness: Double,
    alpha: Double = 1.0,
  ) -> RGBColour {
    return RGBColour(
      red: brightness,
      green: brightness,
      blue: brightness,
      alpha: alpha,
      name: "Gray"
    )
  }

}

extension RGBColour: CustomStringConvertible {
  public var description: String {
    guard let name else {
      return """
        R: \(red), G: \(green), B: \(blue)
        """
    }
    return """
      RGBColour: \(name)
      """
  }
}
