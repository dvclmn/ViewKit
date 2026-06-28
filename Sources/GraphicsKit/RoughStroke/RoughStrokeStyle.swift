//
//  RoughStroke.swift
//  Components
//
//  Created by Dave Coleman on 11/12/2024.
//

import CoreTools
import ViewTools
import ViewKitCore
import SwiftUI

/// Defines the characteristics of a rough stroke
public struct RoughPathStyle: Sendable {
  var roughness: CGFloat
  var segments: Int
  var seed: UInt64
  var jitter: CGFloat

  public static let `default` = RoughPathStyle(
    roughness: 10,
    segments: 20,
    seed: 0,
    jitter: 1.0
  )

  public init(
    roughness: CGFloat = 10,
    segments: Int = 20,
    seed: UInt64 = 0,
    jitter: CGFloat = 1.0
  ) {
    self.roughness = roughness
    self.segments = segments
    self.seed = seed
    self.jitter = jitter
  }
}

public struct RoughPathVariations: RandomGeneratable, Sendable {
  public typealias Value = CGFloat

  let xOffsets: [CGFloat]
  let yOffsets: [CGFloat]
  let pointCount: Int

  public static func generate(
    count: Int,
    using generator: inout any RandomNumberGenerator,
    parameters: RandomisationParameters<Value>
  ) -> RoughPathVariations {
    // Prefer typed influences if defined; fall back to legacy string keys; then to defaults
    let roughness: CGFloat = (
      parameters.influence(for: .roughness) ??
      (parameters.influence(for: InfluenceKey<Double>("roughness")).map { CGFloat($0) }) ??
      CGFloat(10)
    )
    let jitter: CGFloat = (
      parameters.influence(for: .jitter) ??
      (parameters.influence(for: InfluenceKey<Double>("jitter")).map { CGFloat($0) }) ??
      CGFloat(1.0)
    )

    let xOffsets = (0..<count).map { _ in
      CGFloat.random(in: -roughness...roughness, using: &generator) * jitter
    }

    let yOffsets = (0..<count).map { _ in
      CGFloat.random(in: -roughness...roughness, using: &generator) * jitter
    }

    return RoughPathVariations(
      xOffsets: xOffsets,
      yOffsets: yOffsets,
      pointCount: count
    )
  }
}

