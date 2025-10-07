//
//  Handler+Wave.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//

import BaseHelpers
import CurveKit
import SwiftUI

@Observable
final class WaveHandler {
  var xPositions: [CGFloat] = []
  var spatialPhases: [CGFloat] = []
  var baseLinePath: Path = .init()
  var lastComputedSize: CGSize = .zero
  var lastComputedSampleCount: Int = 0
  var isHovering: Bool = false

  @ObservationIgnored let emphasisPadding: CGFloat = Styles.sizeSmall
}

extension WaveHandler {

  func needsRecomputation(
    size: CGSize,
    sampleCount: Int
  ) -> Bool {
    return xPositions.count != sampleCount
      || spatialPhases.count != sampleCount
      || lastComputedSize != size
      || lastComputedSampleCount != sampleCount
  }

  func recomputeStatic(
    for size: CGSize,
    wave: Wave,
    sampleCount: Int
  ) {
    guard sampleCount > 1 else {
      xPositions = []
      spatialPhases = []
      return
    }

    /// X positions - ensure we don't divide by zero
    let step = size.width / CGFloat(sampleCount - 1)
    xPositions = (0..<sampleCount).map { CGFloat($0) * step }

    /// Spatial phases
    let kx = size.width > 0 ? (2 * .pi * wave.cyclesAcross) / size.width : 0
    spatialPhases = xPositions.map { kx * $0 }

    /// Horizon path
    baseLinePath = Path { p in
      p.move(to: CGPoint(x: 0, y: size.height / 2))
      p.addLine(to: CGPoint(x: size.width, y: size.height / 2))
    }

    /// Update tracking variables
    lastComputedSize = size
    lastComputedSampleCount = sampleCount
  }

  /// Generates both normal and ghost points in a single pass
  func generateWavePoints(
    normalPhase: CGFloat,
    ghostPhase: CGFloat?,
    amp: CGFloat,
    viewHeight: CGFloat,
    //    size: CGSize,
    sampleCount: Int
  ) -> (normal: [CGPoint], ghost: [CGPoint]?) {
    guard spatialPhases.count == sampleCount,
      xPositions.count == sampleCount
    else {
      return ([], nil)
    }

    let centerY = viewHeight / 2
    var normalPoints: [CGPoint] = []
    normalPoints.reserveCapacity(sampleCount)

    /// Only allocate ghost array if needed
    var ghostPoints: [CGPoint]? = ghostPhase != nil ? [] : nil
    ghostPoints?.reserveCapacity(sampleCount)

    for i in 0..<sampleCount {
      let x = xPositions[i]
      let spatialPhase = spatialPhases[i]

      let yNormal = centerY + amp * sin(normalPhase + spatialPhase)
      normalPoints.append(CGPoint(x: x, y: yNormal))

      if let gPhase = ghostPhase {
        let yGhost = centerY + amp * sin(gPhase + spatialPhase)
        ghostPoints?.append(CGPoint(x: x, y: yGhost))
      }
    }

    return (normalPoints, ghostPoints)
  }
}
