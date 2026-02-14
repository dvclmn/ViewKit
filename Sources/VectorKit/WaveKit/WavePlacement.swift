//
//  WavePlacement.swift
//  BaseDemos
//
//  Created by Dave Coleman on 12/2/2026.
//

import CoreTools
import SwiftUI

// MARK: - WavePlacement

/// Describes how a waveform is oriented through a view, using
/// normalised unit-space coordinates (0–1 on each axis).
///
/// A `WavePlacement` is a directed line segment from `start` to `end`,
/// both expressed as `UnitPoint`s. This encodes three things at once:
///   - **Direction** — which way the waveform travels
///   - **Extent / magnitude** — does it span the full view, or only part of it?
///   - **Offset** — is it centred, or pushed toward one edge?
///
/// At draw time, a sample index is lerped along this segment to produce
/// a concrete `CGPoint` in the view's coordinate space.
///
/// ## Common usage
/// ```swift
/// WavePlacement.horizontal  // leading → trailing, full width
/// WavePlacement.vertical.reversed  // bottom → top, full height
/// WavePlacement.horizontal.inset(by: 0.1)  // 10%…90%, centred
/// WavePlacement(from: .leading, to: UnitPoint(x: 1, y: 0.5))
/// ```
public struct WavePlacement: Equatable, Sendable, Codable, Hashable {

  /// The normalised start point of the waveform path (0–1 per axis).
  public let start: UnitPoint

  /// The normalised end point of the waveform path (0–1 per axis).
  public let end: UnitPoint

  /// Creates a placement from two explicit unit points.
  public init(from start: UnitPoint, to end: UnitPoint) {
    self.start = start
    self.end = end
  }
}

// MARK: - Normalised index resolution

extension WavePlacement {
  
  public var isHorizontal: Bool { self == .horizontal }
  public var isVertical: Bool { self == .vertical }

  /// Returns the normalised `UnitPoint` for a given sample index.
  ///
  /// This is the core calculation: linearly interpolate along the
  /// `start → end` segment at parameter `t = index / (sampleCount - 1)`.
  ///
  /// - Parameters:
  ///   - index: The sample index (0 … sampleCount - 1).
  ///   - sampleCount: Total number of samples in the waveform.
  /// - Returns: A `UnitPoint` in 0–1 space representing this sample's position.
  public func normalisedPoint(at index: Int, sampleCount: Int) -> UnitPoint {
    guard sampleCount > 1 else { return start }
    let t = Double(index) / Double(sampleCount - 1)
    return UnitPoint(
      x: start.x + (end.x - start.x) * t,
      y: start.y + (end.y - start.y) * t
    )
  }

  /// Resolves a sample index to a concrete `CGPoint` within a given view size.
  ///
  /// Prefer `normalisedPoint(at:sampleCount:)` if you want to keep
  /// things in unit space; call this at the final draw site.
  public func point(
    at index: Int,
    sampleCount: Int,
    in size: CGSize
  ) -> CGPoint {
    let u = normalisedPoint(at: index, sampleCount: sampleCount)
    return CGPoint(
      x: u.x * size.width,
      y: u.y * size.height
    )
  }
}

// MARK: - Semantic presets

@StaticMemberIterable
extension WavePlacement {

  /// Horizontal, left → right, full width, vertically centred.
  public static let horizontal = WavePlacement(from: .leading, to: .trailing)

  /// Vertical, top → bottom, full height, horizontally centred.
  public static let vertical = WavePlacement(from: .top, to: .bottom)

  // MARK: Diagonal

  /// Top-leading → bottom-trailing.
  public static let diagonal = WavePlacement(from: .topLeading, to: .bottomTrailing)

  /// Top-trailing → bottom-leading.
  public static let diagonalReversed = WavePlacement(from: .topTrailing, to: .bottomLeading)

  // MARK: Radial / centred

  /// Centre → trailing edge. Useful for radial-style waveforms.
  public static let centreToTrailing = WavePlacement(from: .center, to: .trailing)

  /// Centre → bottom edge.
  public static let centreToBottom = WavePlacement(from: .center, to: .bottom)
}

// MARK: - Modifiers

extension WavePlacement {

  /// Reverses the direction of travel — swaps `start` and `end`.
  public var reversed: WavePlacement {
    WavePlacement(from: end, to: start)
  }

  /// Insets both ends of the segment symmetrically by `amount` (0–0.5).
  ///
  /// `amount: 0.1` produces a segment that runs from 10% to 90% of
  /// the full axis length, centred within the view.
  ///
  /// ```swift
  /// WavePlacement.horizontal.inset(by: 0.1)
  /// // → UnitPoint(x: 0.1, y: 0.5) … UnitPoint(x: 0.9, y: 0.5)
  /// ```
  public func inset(by amount: Double) -> WavePlacement {
    WavePlacement(
      from: UnitPoint(
        x: start.x + (end.x - start.x) * amount,
        y: start.y + (end.y - start.y) * amount
      ),
      to: UnitPoint(
        x: end.x - (end.x - start.x) * amount,
        y: end.y - (end.y - start.y) * amount
      )
    )
  }

  /// Scales the segment to a fractional `extent` of its current length,
  /// keeping the same start point.
  ///
  /// `extent: 0.5` makes the waveform occupy only the first half of
  /// the current `start → end` span.
  public func scaled(to extent: Double) -> WavePlacement {
    WavePlacement(
      from: start,
      to: UnitPoint(
        x: start.x + (end.x - start.x) * extent,
        y: start.y + (end.y - start.y) * extent
      )
    )
  }

  /// Offsets both `start` and `end` by a unit-space delta,
  /// preserving the direction and length of the segment.
  ///
  /// Useful for nudging a waveform away from an edge without
  /// changing its orientation.
  public func offset(x: Double = 0, y: Double = 0) -> WavePlacement {
    WavePlacement(
      from: UnitPoint(x: start.x + x, y: start.y + y),
      to: UnitPoint(x: end.x + x, y: end.y + y)
    )
  }

  /// Mirrors the placement horizontally (reflects x-axis).
  public var mirroredHorizontally: WavePlacement {
    WavePlacement(
      from: UnitPoint(x: 1 - start.x, y: start.y),
      to: UnitPoint(x: 1 - end.x, y: end.y)
    )
  }

  /// Mirrors the placement vertically (reflects y-axis).
  public var mirroredVertically: WavePlacement {
    WavePlacement(
      from: UnitPoint(x: start.x, y: 1 - start.y),
      to: UnitPoint(x: end.x, y: 1 - end.y)
    )
  }
}

// MARK: - Descriptive helpers

extension WavePlacement {

  /// The vector from `start` to `end` in unit space.
  public var unitVector: CGVector {
    CGVector(dx: end.x - start.x, dy: end.y - start.y)
  }

  /// The normalised length of the segment (0–√2 for a unit square).
  public var length: Double {
    let v = unitVector
    return sqrt(v.dx * v.dx + v.dy * v.dy)
  }

  /// The direction angle of the segment in radians, measured from
  /// the positive x-axis. Useful for rotating amplitude bars
  /// perpendicular to the wave's travel direction.
  public var angle: Angle {
    Angle(radians: atan2(unitVector.dy, unitVector.dx))
  }

  /// The angle perpendicular to the wave's direction of travel.
  /// Use this to orient amplitude bars / tick marks.
  public var perpendicularAngle: Angle {
    Angle(radians: angle.radians + .pi / 2)
  }
}

// MARK: - Canvas drawing integration

extension WavePlacement {

  /// Resolves all sample positions at once, as `CGPoint`s in the given size.
  ///
  /// Convenient when you want to map over samples in a Canvas draw block.
  public func allPoints(sampleCount: Int, in size: CGSize) -> [CGPoint] {
    (0..<sampleCount).map { point(at: $0, sampleCount: sampleCount, in: size) }
  }

  /// Returns the concrete start/end `CGPoint`s for drawing a baseline
  /// or axis reference line.
  public func resolvedSegment(in size: CGSize) -> (start: CGPoint, end: CGPoint) {
    (
      start: CGPoint(x: start.x * size.width, y: start.y * size.height),
      end: CGPoint(x: end.x * size.width, y: end.y * size.height)
    )
  }
}

extension WavePlacement: CustomStringConvertible {
  public var description: String {
    "Start: \(start.displ)"
  }
}

// MARK: - Example usage (Canvas waveform sketch)

/*

 Canvas { ctx, size in
 let placement = WavePlacement.horizontal.inset(by: 0.05)
 let samples: [Float] = waveform.samples

 for (index, amplitude) in samples.enumerated() {
 let position = placement.point(at: index, sampleCount: samples.count, in: size)
 let barHeight = CGFloat(amplitude) * size.height * 0.5

 // Draw amplitude bar perpendicular to the wave direction
 let angle = placement.perpendicularAngle
 let bar = Path { p in
 let dx = cos(angle.radians) * barHeight
 let dy = sin(angle.radians) * barHeight
 p.move(to: CGPoint(x: position.x - dx, y: position.y - dy))
 p.addLine(to: CGPoint(x: position.x + dx, y: position.y + dy))
 }
 ctx.stroke(bar, with: .color(.blue), lineWidth: 2)
 }
 }

 // Readable call sites:
 WavePlacement.vertical.reversed                    // bottom-up
 WavePlacement.horizontal.inset(by: 0.1)            // padded edges
 WavePlacement.horizontal.inset(by: 0.1).reversed   // padded, RTL
 WavePlacement.diagonal.scaled(to: 0.6)             // partial diagonal
 WavePlacement(from: .leading, to: .bottom)         // custom L-shaped

 */
