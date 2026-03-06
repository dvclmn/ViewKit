//
//  Models.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

//import ColourKit
import SwiftUI

public struct Stroke: Hashable, Codable, Sendable, Identifiable {
  public let id: UUID
  public var points: [CGPoint]

  public init(points: [CGPoint]) {
    self.id = UUID()
    self.points = points
  }
}

extension Stroke {
  public var rawPoints: [CGPoint] { points }

  public func sampledPoints(every stride: Int) -> [CGPoint] {
    rawPoints.sampled(every: stride)
  }
}
