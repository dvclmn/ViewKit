//
//  Model+Appearance.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import Foundation
import SharedHelpers

@available(macOS 14.0, *)
public struct FloorAppearance: Sendable, Codable, Equatable, Hashable {
  
  public var pattern: PatternConfiguration
  public var degrees: Double
  public var perspective: Double
  public var width: Double
  public var depth: Double
  public var zoom: Double
  public var yaw: Double

  public init(
    pattern: PatternConfiguration = .checkboardExample,
    degrees: Double = 30,
    perspective: Double = 3,
    width: Double = 2,
    depth: Double = 0.9,
    zoom: Double = .zero,
    yaw: Double = .zero
  ) {
    self.pattern = pattern
    self.degrees = degrees
    self.perspective = perspective
    self.width = width
    self.depth = depth
    self.zoom = zoom
    self.yaw = yaw
  }
}
