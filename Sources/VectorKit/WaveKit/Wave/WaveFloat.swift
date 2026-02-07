//
//  WaveFloat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import CoreTools
import SwiftUI

public protocol WaveFloat: BinaryFloatingPoint, Sendable, Codable, StringRenderable, FloatRenderable {
  static func waveSin(_ x: Self) -> Self
  static var twoPi: Self { get }
}

extension Float: WaveFloat {
  public static func waveSin(_ x: Self) -> Self { Foundation.sin(x) }
  public static var twoPi: Self { .pi * 2 }
}

extension Double: WaveFloat {
  public static func waveSin(_ x: Self) -> Self { Foundation.sin(x) }
  public static var twoPi: Self { .pi * 2 }
}

extension CGFloat: WaveFloat {
  public static func waveSin(_ x: Self) -> Self { Darwin.sin(x) }
  public static var twoPi: Self { .pi * 2 }
}

extension CGPoint {
  public init<T: WaveFloat>(fromWaveFloat x: T, y: T) {
    self.init(
      x: CGFloat(x),
      y: CGFloat(y)
    )
  }
}

extension Binding where Value: WaveFloat {

  public var toBindingFloat: Binding<CGFloat> {
    Binding<CGFloat>(
      get: { CGFloat(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }
  public var toBindingDouble: Binding<Double> {
    Binding<Double>(
      get: { Double(wrappedValue) },
      set: { wrappedValue = Value($0) }
    )
  }
}
