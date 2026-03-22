//
//  ValueFormatter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import Foundation

/// A value formatter that can optionally use the range context
/// provided by the host control (e.g. `QuickSlider`).
public struct ValueFormatter: Sendable {
  public let format: @Sendable (Double, ClosedRange<Double>) -> String
  
  public init(_ format: @escaping @Sendable (Double, ClosedRange<Double>) -> String) {
    self.format = format
  }
  
  /// Convenience for formatters that don't need the range.
  public init(_ format: @escaping @Sendable (Double) -> String) {
    self.format = { value, _ in format(value) }
  }
  
  public static var `default`: Self {
    .init { value, _ in value.displayString }
  }
  
  /// Converts the raw value to a percentage within the host control's range.
  public static func percent(decimalPlaces: Int = 0) -> Self {
    .init { value, range in
      value.toPercentString(within: range, decimalPlaces: decimalPlaces)
    }
  }
  
  /// Shorthand for `.percent(decimalPlaces: 0)`
  public static var percent: Self { .percent() }
}
