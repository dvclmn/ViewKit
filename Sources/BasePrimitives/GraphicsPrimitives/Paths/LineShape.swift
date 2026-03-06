//
//  LineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CasePaths
//import CoreTools
import SwiftUI
//import VectorKit

@MetaEnum
@CaseDetection
@CasePathable
@dynamicMemberLookup
public enum LineShape: CaseIterable, Identifiable, Sendable, Codable, Equatable, Hashable {
  public static let allCases: [LineShape] = [.triangle, .diamond, .wave()]
  case triangle
  case diamond
  case wave(
    strength: Double = 0.5,
    sampleCount: Int = 30
  )

  public var id: String { name }

  public var name: String {
    switch self {
      case .triangle: "triangle"
      case .diamond: "diamond"
      case .wave: "wave"
    }
  }
  public var icon: String {
    switch self {
      case .triangle: "triangle"
      case .diamond: "diamond"
      case .wave: "water.waves"
    }
  }
}

extension LineShape {
  public func path(
    from start: CGPoint,
    to end: CGPoint,
    with style: ActionLine.LineStyle
  ) -> (Path, cycles: Double) {
    switch self {
      case .triangle:
        trianglePath(
          from: start,
          to: end,
          minWidth: style.minWidth,
          maxWidth: style.maxWidth
        )
      case .diamond:
        diamondPath(
          from: start,
          to: end,
          minWidth: style.minWidth,
          maxWidth: style.maxWidth
        )
      case .wave(let strength, let samples):
//      case .wave(let strength, let phaseOffset, let samples):
        wavePath(
          from: start,
          to: end,
          with: style,
          strength: strength,
          phaseOffset: style.phaseOffset,
          samples: samples
        )
    }
  }
}

extension LineShape {

  /// Reference length where full cycles are reached.
  /// Lines shorter than this length smoothly reduce cycles toward zero.
  private var referenceLengthForCycles: CGFloat { 200 }
  private var minCycles: Double { 0 }

  /// Scales the requested cycle count based on the length of the line.
  ///
  /// - Parameters:
  ///   - cycles: The desired number of cycles on a sufficiently long line.
  ///   - lineLength: The current length of the line.
  /// - Returns: A moderated cycle count that smoothly approaches zero on very short lines and reaches full cycles at the reference length.
  func effectiveCycles(
    cycles: Double,
    lineLength: Double,
  ) -> Double {
    guard cycles > 0, lineLength > 0 else { return 0 }

    var t = min(max(lineLength / referenceLengthForCycles, 0), 1)
    t = t * t * (3 - 2 * t)  // smoothstep easing

    return min(max(minCycles, cycles * t), cycles)
  }
}
