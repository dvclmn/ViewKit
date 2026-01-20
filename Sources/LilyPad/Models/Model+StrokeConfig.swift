//
//  Model+StrokeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import ColourKit
import Foundation
import VectorKit
import CasePaths
import CoreTools

public struct StrokeConfig: Sendable, Hashable, Codable {
  public let colour: RGBColour
  public let lineWidth: CGFloat
  public var style: PathStyle
  
  public var lastKnownRadius: Double?

  public init(
    colour: RGBColour = .brown,
    lineWidth: CGFloat = 3.0,
    style: PathStyle = .smooth
  ) {
    self.colour = colour
    self.lineWidth = lineWidth
    self.style = style
  }
}

extension StrokeConfig {
  public mutating func updateStyle(_ newStyle: PathStyle) {
    self.style = newStyle
    //    self = Self(style: newStyle, shape: shape, radius: radius)
  }
  
  public var styleRadius: Double {
    style[case: \.stamped]?.radius ?? lastKnownRadius ?? 1.0
  }

}

extension StrokeConfig: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Indented("StrokeConfig") {
        Labeled("Colour", value: colour)
        Labeled("Line width", value: lineWidth)
        Labeled("style", value: style)
        if let lastKnownRadius {
          Labeled("Last known Style radius", value: lastKnownRadius)
        }
      }
    }.text
  }
}
