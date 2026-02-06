//
//  LineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools

@CaseDetection
public enum LineShape: String, CaseIterable, Identifiable, Sendable, Codable {
  case triangle
  case diamond
  case wave

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
  public var icon: String {
    switch self {
      case .triangle: "triangle"
      case .diamond: "diamond"
      case .wave: "water.waves"
    }
  }
}
