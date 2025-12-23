//
//  Model+RGB.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SharedHelpers
import SwiftUI

//@available(macOS 14.0, *)
public struct RGBColour: Identifiable, Equatable, Hashable, Sendable, Codable,
  ColourModel, HSVAdjustable
{
  public let id: UUID
  public var red: Double
  public var green: Double
  public var blue: Double
  public var alpha: Double

  public var name: String?

  public init(
    red: Double,
    green: Double,
    blue: Double,
    alpha: Double = 1.0,
    name: String? = nil
  ) {
    self.id = UUID()
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
    self.name = name
  }

  public init(
    r: Double,
    g: Double,
    b: Double,
    a: Double = 1.0,
    name: String?
  ) {
    self.init(red: r, green: g, blue: b, alpha: a, name: name)
  }

}
@available(macOS 14.0, *)
extension RGBColour {
  public init(fromSystem system: SystemColour, env: EnvironmentValues) {
    self.init(
      colour: system.toColour,
      environment: env,
      name: system.name
    )
  }
}

//@available(macOS 14.0, *)
extension RGBColour {

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

//@available(macOS 14.0, *)
extension RGBColour: CustomStringConvertible {
  public var description: String {
    let result = """
      RGBColour[R: \(red), G: \(green), B: \(blue), Name: \(name ?? "nil")]
      """

    return result
  }
}
