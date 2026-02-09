//
//  LineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CasePaths
import CoreTools
import SwiftUI
import VectorKit

@MetaEnum
@CaseDetection
@CasePathable
@dynamicMemberLookup
public enum LineShape: CaseIterable, Identifiable, Sendable, Codable, Equatable, Hashable {
  public static let allCases: [LineShape] = [.triangle, .diamond, .wave()]
  case triangle
  case diamond
  case wave(sampleCount: Int = 30)

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
        let path = Path { path in
          let angle = atan2(end.y - start.y, end.x - start.x)
          let perpAngle: Double = angle + Double.pi / 2

          let x1 = end.x + cos(perpAngle) * style.minWidth
          let y1 = end.y + sin(perpAngle) * style.maxWidth
          let x2 = end.x - cos(perpAngle) * style.minWidth
          let y2 = end.y - sin(perpAngle) * style.maxWidth

          path.move(to: start)
          path.addLine(to: CGPoint(x: x1, y: y1))
          path.addLine(to: CGPoint(x: x2, y: y2))
          path.closeSubpath()
        }
        return (path, 0.0)

      case .diamond:
        let path = Path { path in
          let angle = atan2(end.y - start.y, end.x - start.x)
          let perpAngle: Double = angle + Double.pi / 2
          let mid = start.midpoint(to: end)
          //      let mid = CGPoint(x: (start.x + end.x) / 2, y: (start.y + end.y) / 2)

          let perpOffsetX = cos(perpAngle) * style.minWidth
          let perpOffsetY = sin(perpAngle) * style.maxWidth

          let perp1 = CGPoint(x: mid.x + perpOffsetX, y: mid.y + perpOffsetY)
          let perp2 = CGPoint(x: mid.x - perpOffsetX, y: mid.y - perpOffsetY)
          path.move(to: start)
          path.addLine(to: perp1)
          path.addLine(to: end)
          path.addLine(to: perp2)
          path.closeSubpath()
        }
        return (path, 0.0)

      case .wave(let samples):
        let length = start.distance(to: end)

        let cycles = effectiveCycles(
          cycles: style.cycles,
          lineLength: length
        )

        let amplitude = style.width
        let dx = end.x - start.x
        let dy = end.y - start.y

        /// Create the spine path (centerline of the wave)
        var spinePath = Path()
        let angle = atan2(dy, dx)
        let perp = CGPoint(x: -sin(angle), y: cos(angle))

        for i in 0...samples {
          let t = Double(i) / Double(samples)
          let px = start.x + dx * t
          let py = start.y + dy * t

          let phaseTurns = t * cycles
          let wave = WaveSampler<Double>.sample(.sine, phase: phaseTurns, domain: .turns)

          let wx = px + perp.x * wave * amplitude
          let wy = py + perp.y * wave * amplitude
          let pt = CGPoint(x: wx, y: wy)

          if i == 0 {
            spinePath.move(to: pt)
          } else {
            spinePath.addLine(to: pt)
          }
        }

        /// Create variable-width path with tapered ends
        let path = Path.variableWidthPath(
          spine: spinePath,
          profile: .tapered(min: style.minWidth, max: style.maxWidth),
          samples: samples
        )
        return (path, cycles)
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
