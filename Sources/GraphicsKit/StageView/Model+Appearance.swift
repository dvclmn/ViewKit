//
//  Model+Appearance.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/8/2025.
//

import BasePrimitives
import Foundation

// TODO: Need to be clearer about what these properties do/mean
public struct FloorAppearance: Sendable, Codable, Equatable, Hashable {

  public var pattern: PatternPreset
//  public var pattern: PatternConfiguration
  public var degrees: Double
  public var perspective: Double
  public var width: Double
  public var depth: Double
  public var zoom: Double
  public var yaw: Double

  public init(
    pattern: PatternPreset = .init(
      style: .checkerboard,
      config: .default
    ),
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

extension FloorAppearance {
  public static let checkerboard: Self = .init(
    pattern: .init(),
    degrees: 0,
    perspective: 1,
    width: 100,
    depth: 0.2,
    zoom: 1.0,
    yaw: 1.0
  )
}
