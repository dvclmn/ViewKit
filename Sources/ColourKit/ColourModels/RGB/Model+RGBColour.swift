//
//  Model+RGB.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import BasePrimitives
import SwiftUI

public struct RGBColour: Identifiable, Equatable, Hashable, Sendable, Codable,
  ColourModel, HSVAdjustable
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
extension RGBColour {

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

  public var toHSV: HSVColour { HSVColour(fromRGB: self) }

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

//
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
