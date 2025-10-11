//
//  SwiftUIResolvable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/10/2025.
//

import SwiftUI

extension RGBColour: SwiftUIColourResolvable {

  public var swiftUIColour: Color {
    Color(
      colourSpace,
      red: red,
      green: green,
      blue: blue,
      opacity: alpha
    )
  }

  public init(
    colour: Color,
    environment: EnvironmentValues,
    name: String?
  ) {
    let resolved = colour.resolve(in: environment)
    self.init(
      resolved: resolved,
      name: name
    )
  }

  public init(
    resolved: Color.Resolved,
    name: String?
  ) {
    self.init(
      red: resolved.red.toDouble,
      green: resolved.green.toDouble,
      blue: resolved.blue.toDouble,
      alpha: resolved.opacity.toDouble,
      name: name
    )
  }

}

extension HSVColour: SwiftUIColourResolvable {

  public var swiftUIColour: Color {
    Color(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      opacity: alpha
    )
  }

  public init(
    colour: Color,
    environment: EnvironmentValues,
    name: String?
  ) {
    let resolved = colour.resolve(in: environment)
    self.init(resolved: resolved, name: name)
  }

  public init(
    resolved: Color.Resolved,
    name: String?
  ) {
    let rgba = RGBColour(resolved: resolved, name: name)
    self.init(fromRGB: rgba)
  }
}
