//
//  LinePath+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/2/2026.
//

import Foundation

extension LinePathContext {
  private var lineLength: CGFloat { start.distance(to: end) }
  // Tunable thresholds for cycle moderation
  // Lines shorter than `minLengthForFullCycles` reduce cycles down toward `minCycles`.
  // Lines at or above `maxLengthForFullCycles` keep the full requested cycles.
  private var minLengthForFullCycles: CGFloat { 80 }  // tweak
  private var maxLengthForFullCycles: CGFloat { 240 }  // tweak
  private var minCycles: Double { 0.5 }  // tweak: allow half a cycle at minimum

  /// Maps the desired cycles to a moderated value based on `lineLength`.
  /// - For very short lines, cycles approach `minCycles`.
  /// - For long lines, cycles approach the original `style.cycles`.
  package func moderatedCycles(for desired: Double) -> Double {
    // If desired is already very small, just return it.
    guard desired > 0 else { return 0 }

    let L = lineLength
    // If line is long enough, keep full cycles
    if L >= maxLengthForFullCycles { return desired }

    // If line is extremely short, clamp to minCycles
    if L <= minLengthForFullCycles { return max(minCycles, min(desired, desired)) }

    // Otherwise, interpolate between minCycles and desired based on normalized length
    let t = Double((L - minLengthForFullCycles) / (maxLengthForFullCycles - minLengthForFullCycles))
    // Smoothstep for a gentler transition
    let smooth = t * t * (3 - 2 * t)
    let value = minCycles + (desired - minCycles) * smooth
    return max(minCycles, min(value, desired))
  }
}
