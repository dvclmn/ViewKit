//
//  LineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools
import SwiftUI
import VectorKit
import CasePaths

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
  //  private var lineLength: CGFloat {  }

  /// Tunable thresholds for cycle moderation
  /// Lines shorter than `minLengthForFullCycles` reduce cycles down toward `minCycles`.
  /// Lines at or above `maxLengthForFullCycles` keep the full requested cycles.
  private var minLengthForFullCycles: CGFloat { 80 }  // tweak
  private var maxLengthForFullCycles: CGFloat { 240 }  // tweak
  private var minCycles: Double { 0.5 }  // tweak: allow half a cycle at minimum

  /// Maps the desired cycles to a moderated value based on `lineLength`.
  /// - For very short lines, cycles approach `minCycles`.
  /// - For long lines, cycles approach the original `style.cycles`.
  func effectiveCycles(
    cycles: Double,
    lineLength: Double,
    //    style: ActionLine.LineStyle
  ) -> Double {

    let desired = cycles
    /// If desired is already very small, just return it.
    guard cycles > 0 else { return 0 }

    //    let length = start.distance(to: end)
    /// If line is long enough, keep full cycles
    if lineLength >= maxLengthForFullCycles { return desired }

    /// If line is extremely short, clamp to minCycles
    if lineLength <= minLengthForFullCycles { return max(minCycles, min(desired, desired)) }

    /// Otherwise, interpolate between minCycles and desired based on normalized length
    let t = Double((lineLength - minLengthForFullCycles) / (maxLengthForFullCycles - minLengthForFullCycles))

    /// Smoothstep for a gentler transition
    let smooth = t * t * (3 - 2 * t)
    let value = minCycles + (desired - minCycles) * smooth
    return max(minCycles, min(value, desired))
  }
}
