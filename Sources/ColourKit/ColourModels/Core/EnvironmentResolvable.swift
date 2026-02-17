//
//  EnvironmentResolvable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

public protocol EnvironmentResolvableColour {
  

  init(
    colour: Color,
    environment: EnvironmentValues,
    name: String?
  )

  init(
    resolved: Color.Resolved,
    name: String?
  )
}

extension RGBColour: EnvironmentResolvableColour {

  

  public func toCGColour(in env: EnvironmentValues) -> CGColor? {
    toColour.resolve(in: env).cgColor
  }
}

extension RGBColour {
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

extension HSVColour: EnvironmentResolvableColour {

}

extension HSVColour {

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
