//
//  WaveFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation
import CoreTools

public protocol WaveFloat: BinaryFloatingPoint, Sendable, Codable, StringRenderable, FloatRenderable {
  static func wf_sin(_ x: Self) -> Self
}
//extension Float: WaveFloat {}
//extension CGFloat: WaveFloat {}
//extension Double: WaveFloat {}

extension Float: WaveFloat {
  public static func wf_sin(_ x: Float) -> Float { Foundation.sin(x) }
}

extension Double: WaveFloat {
  public static func wf_sin(_ x: Double) -> Double { Foundation.sin(x) }
}

extension CGFloat: WaveFloat {
  public static func wf_sin(_ x: CGFloat) -> CGFloat { Darwin.sin(x) }
  // Alternatively: return CGFloat(Foundation.sin(Double(x)))
}

extension CGPoint {
  public init<T: WaveFloat>(fromWaveFloat x: T, y: T) {
    self.init(
      x: CGFloat(x),
      y: CGFloat(y)
    )
  }
}
