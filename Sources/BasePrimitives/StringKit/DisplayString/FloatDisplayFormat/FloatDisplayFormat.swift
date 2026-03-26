//
//  FloatDisplayFormat.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import Foundation

/// Describes how a single floating-point value is formatted.
/// Deliberately limited to numeric concerns only — no separator,
/// label, or grouping/joining logic lives here.
public struct FloatDisplayFormat: Equatable, Sendable {
  public var decimalPlaces: Int
  public var integerLength: Int?
  public var grouping: NumberGrouping
  public var sign: SignDisplay

  public init(
    decimalPlaces: Int = 2,
    integerLength: Int? = nil,
    grouping: NumberGrouping = .automatic,
    sign: SignDisplay = .standard
  ) {
    self.decimalPlaces = decimalPlaces
    self.integerLength = integerLength
    self.grouping = grouping
    self.sign = sign
  }
}

extension FloatDisplayFormat {
  public static func fromPreset(_ preset: FloatDisplayPreset) -> Self {
    preset.format
  }

  public func with(integerLength: Int) -> Self {
    var copy = self
    copy.integerLength = integerLength
    return copy
  }

  public static var `default`: Self { .init() }
}

extension BinaryFloatingPoint {
  public func toPercentString(
    within range: ClosedRange<Self>,
    decimalPlaces: Int = 0
  ) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.render(using: .init(decimalPlaces: decimalPlaces)) + "%")
  }
}
