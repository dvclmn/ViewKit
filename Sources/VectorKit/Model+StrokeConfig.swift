//
//  Model+StrokeStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

//import CasePaths
// import ColourKit
//import CoreTools
import Foundation
import BasePrimitives
//import VectorKit

public struct StrokeConfig: Sendable, Hashable, Codable {
  public let colour: RGBColour
  public let lineWidth: CGFloat
  public var style: PathStyle

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
  }

  public static var example01: Self { Self(.green, lineWidth: 5, style: .smooth) }
  public static var example02: Self { Self(.orange, lineWidth: 3, style: .line) }
  public static var example03: Self {
    Self(
      .brown,
      lineWidth: 2,
      style: .stamped(shape: .circle, radius: 30)
    )
  }
}

extension StrokeConfig: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Indented("StrokeConfig") {
        Labeled("Colour", value: colour)
        Labeled("Line width", value: lineWidth)
        Labeled("style", value: style)
      }
    }.text
  }
}
