//
//  Model+StrokeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import ColourKit
import Foundation
import VectorKit

public struct StrokeConfig: Sendable, Hashable, Codable {
  public let colour: RGBColour
  public let lineWidth: CGFloat
  public var style: PathStyle

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
  

}


