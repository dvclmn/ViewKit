//
//  Model+StrokeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import CasePaths
import ColourKit
import CoreTools
import Foundation
import VectorKit

public struct StrokeConfig: Sendable, Hashable, Codable {
  public let colour: RGBColour
  public let lineWidth: CGFloat
  public var style: PathStyle

  //  public var lastKnownRadius: Double?

  public init(
    _ colour: RGBColour = .brown,
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

  //  public var styleRadius: Double {
  //    style[case: \.stamped]?.radius ?? lastKnownRadius ?? 1.0
  //  }
  public static var example01: Self { Self(.green, lineWidth: 5, style: .smooth) }
  public static var example02: Self { Self(.orange, lineWidth: 3, style: .line) }
  public static var example03: Self {
    Self(.brown, lineWidth: 2, style: .stamped(shape: .circle, radius: 30))
  }
}

extension StrokeConfig: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Indented("StrokeConfig") {
        Labeled("Colour", value: colour)
        Labeled("Line width", value: lineWidth)
        Labeled("style", value: style)
        //        if let lastKnownRadius {
        //          Labeled("Last known Style radius", value: lastKnownRadius)
        //        }
      }
    }.text
  }
}
