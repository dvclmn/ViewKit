//
//  Path+Stamped.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

import Foundation

public struct StampedConfig: Identifiable, Sendable, Hashable, Equatable, Codable {
  public let id: UUID
  public let shape: PointShape
  public let radius: CGFloat

  public init(shape: PointShape = .circle, radius: CGFloat = 3) {
    self.id = UUID()
    self.shape = shape
    self.radius = radius
  }
}

extension StampedConfig {

}
