//
//  Model+StrokePoint.swift
//  Playground
//
//  Created by Dave Coleman on 19/1/2026.
//

import Foundation
import ColourKit
import VectorKit
//public struct PointStyle: Hashable, Sendable, Codable {
//  let colour: RGBColour
//  let radius: CGFloat
//  
//  public init(
//    colour: RGBColour,
//    radius: CGFloat = 2.0
//  ) {
//    self.colour = colour
//    self.radius = radius
//  }
//}

extension PointStyle {
  public static func basic(with colour: RGBColour) -> Self {
    Self(colour: colour)
  }
//  public static let `default`: Self = .init(colour: .black, radius: 3)
}
