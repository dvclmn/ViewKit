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
  public let points: Points
}

extension Stroke {
  public init(
    id: UUID = UUID(),
    points: [CGPoint],
    colour: RGBColour
  ) {
    self.id = id

    let defaultStyled: Points = Dictionary(
      uniqueKeysWithValues: points.map { point in
        let style = PointStyle.basic(with: colour)
        return (style, point)
      }
    )
    self.points = defaultStyled
  }

  public var rawPoints: [CGPoint] { points.values.toArray }

  public func sampledPoints(every stride: Int) -> [CGPoint] {
    rawPoints.sampled(every: stride)
  }
  //  mutating func setPhase(_ phase: InteractionPhase) {
  //    self.phase = phase
  //  }
}
