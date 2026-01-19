//
//  Model+Stroke.swift
//  Playground
//
//  Created by Dave Coleman on 19/1/2026.
//

import Foundation



struct Stroke: Hashable, Codable {
  let id: UUID
  //  var phase: InteractionPhase = .none
  let points: [CGPoint]
  //  let points: [CGPoint]
  
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
  //  mutating func setPhase(_ phase: InteractionPhase) {
  //    self.phase = phase
  //  }
}
