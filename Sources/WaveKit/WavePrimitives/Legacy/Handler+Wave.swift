//
//  Handler+Wave.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/8/2025.
//


import SwiftUI

@Observable
public final class WaveHandler<T: WaveFloat> {
  public var xPositions: [T] = []
  public var spatialPhases: [T] = []
  public var baseLinePath: Path = .init()
  public var lastComputedSize: CGSize = .zero
  public var lastComputedSampleCount: Int = 0
  public var isHovering: Bool = false

  @ObservationIgnored public let emphasisPadding: CGFloat = 8

  public init() {}
}

extension WaveHandler {

  public func needsRecomputation(
    size: CGSize,
    sampleCount: Int
  ) -> Bool {
    return xPositions.count != sampleCount
      || spatialPhases.count != sampleCount
      || lastComputedSize != size
      || lastComputedSampleCount != sampleCount
  }

  public func recomputeStatic(
    for size: CGSize,
    wave: Wave<T>,
    cyclesAcross: T,
    sampleCount: Int
  ) {
    guard sampleCount > 1 else {
      xPositions = []
      spatialPhases = []
      return
    }

    let width = T(size.width)
    //    let height = Float(size.height)

    /// X positions - ensure we don't divide by zero
    let step = width / T(sampleCount - 1)
    xPositions = (0..<sampleCount).map { T($0) * step }

    /// Spatial phases
    let kx = size.width > 0 ? (2 * .pi * cyclesAcross) / width : 0
    //    let kx = size.width > 0 ? (2 * .pi * wave.cyclesAcross) / size.width : 0
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
  public func generateWavePoints(
    normalPhase: T,
    ghostPhase: T?,
    amp: T,
    viewHeight: T,
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

      let yNormal = centerY + amp * T.waveSin(normalPhase + spatialPhase)
      //      let yNormal = centerY + amp * sin(normalPhase + spatialPhase)
      normalPoints.append(
        CGPoint(
          fromWaveFloat: x,
          y: yNormal
        )
      )

      if let gPhase = ghostPhase {
        let yGhost = centerY + amp * T.waveSin(gPhase + spatialPhase)
        ghostPoints?.append(
          CGPoint(
            fromWaveFloat: x,
            y: yGhost
          )
        )
      }
    }

    return (normalPoints, ghostPoints)
  }
}
