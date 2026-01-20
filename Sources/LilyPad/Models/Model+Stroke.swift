//
//  Model+Stroke.swift
//  Playground
//
//  Created by Dave Coleman on 19/1/2026.
//

import ColourKit
import Foundation

public struct Stroke: Hashable, Codable, Sendable {
  public let id: UUID
  public var points: Points
}

extension Stroke {

  public init(
    //    id: UUID = UUID(),
    points: [CGPoint],
    colour: RGBColour
  ) {
    self.id = UUID()
    self.points = Stroke.makePoints(from: points, colour: colour)
  }
}

extension Stroke {

  public var rawPoints: [CGPoint] { points.values.toArray }

  public func sampledPoints(every stride: Int) -> [CGPoint] {
    rawPoints.sampled(every: stride)
  }
  //  mutating func setPhase(_ phase: InteractionPhase) {
  //    self.phase = phase
  //  }
}
