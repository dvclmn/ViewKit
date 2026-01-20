//
//  Path+Stamped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import Foundation

public struct StampedConfig: Sendable, Hashable, Codable {
  let shape: PointShape
  let radius: CGFloat

  public init(shape: PointShape = .circle, radius: CGFloat = 3) {
    self.shape = shape
    self.radius = radius
  }
}

extension StampedConfig {

}
