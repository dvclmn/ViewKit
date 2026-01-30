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

  /// Temporarily setting this to a more simple `[CGPoint]`
  public var points: [CGPoint]
  //  public var points: Points
}

extension Stroke {

  public init(
    //    id: UUID = UUID(),
    points: [CGPoint],
    //    colour: RGBColour
  ) {
    self.id = UUID()
    self.points = points
    //    self.points = Stroke.makePoints(from: points, colour: colour)
  }
}

extension Stroke {

//  public static var example01: Self {
//    Stroke(
//      points: .generateSpiral(
//        start: .quickPreset03.adjust(.horizontal, { $0 + 100 })
//      ),
//    )
//  }
//  public static var example02: Self {
//    Stroke(
//      points: [.quickPreset01, .quickPreset02, .quickPreset03],
//    )
//  }
//  public static var example03: Self {
//    Stroke(
//      points: .generateSpiral(
//        start: .quickPreset02.adjust(.horizontal, { $0 + 20 }),
//        pointCount: 10
//      ),
//    )
//  }

  //  public static var examples: [Stroke] {
  //    [
  //      Stroke(
  //        points: .generateSpiral(
  //          start: .quickPreset03.adjust(.horizontal, { $0 + 100 })
  //        ), colour: .brown),
  //      Stroke(points: [.quickPreset01, .quickPreset02], colour: .blue),
  //      //      Stroke(points: .generateSpiral(start: .quickPreset03), colour: .brown),
  //    ]
  //  }

  public var rawPoints: [CGPoint] { points }
  //  public var rawPoints: [CGPoint] { points.values.toArray }

  public func sampledPoints(every stride: Int) -> [CGPoint] {
    rawPoints.sampled(every: stride)
  }
  //  mutating func setPhase(_ phase: InteractionPhase) {
  //    self.phase = phase
  //  }
}

extension Strokes {
  public static var exampleStyled: Self {
    [
      .example01: .example01,
      .example02: .example02,
      .example03: .example03,
    ]
  }
}
