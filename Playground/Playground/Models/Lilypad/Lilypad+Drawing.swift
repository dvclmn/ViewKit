//
//  Lilypad+Drawing.swift
//  Playground
//
//  Created by Dave Coleman on 16/1/2026.
//

import Foundation
import CoreTools

nonisolated struct DrawingData: Sendable, Codable {
  /// Storing as array to preserve order that strokes were laid down
  var strokes: [Stroke]
//  var strokes: Set<Stroke>
//  var strokes: [CGPoint]
//  var points: [CGPoint]
}
extension DrawingData {
  var pointCount: Int { strokes.map(\.points).count }
  var strokeCount: Int { strokes.count }
}

struct ActiveStroke {
  let id: UUID
  var points: [CGPoint]
}


nonisolated struct Stroke: Hashable, Codable {
  let id: UUID
  var phase: InteractionPhase = .none
  let points: [CGPoint]
  
  enum CodingKeys: String, CodingKey {
    case id, points
  }
  
  init(
    id: UUID = UUID(),
    points: [CGPoint]
  ) {
    self.id = id
    self.points = points
  }
}

extension Stroke {
  mutating func setPhase(_ phase: InteractionPhase) {
    self.phase = phase
  }
}
