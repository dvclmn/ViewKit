//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

public protocol FloatRenderable: BinaryFloatingPoint & Sendable {
//public protocol FloatRenderable: BinaryFloatingPoint & Sendable & StringRenderable {
  func render(using format: DisplayFormat) -> String
}

// MARK: - Conformances
extension Double: FloatRenderable {}
extension CGFloat: FloatRenderable {}
extension Float: FloatRenderable {}

extension FloatRenderable {
  public func render(using format: DisplayFormat = .default) -> String {

    let result: String
    if let integerLength = format.integerLength {
      result = renderWithIntegerLength(integerLength, format: format)
    } else {
      result = renderWithoutIntegerLength(format: format)
    }

    return format.sign.shouldPostProcess
      ? format.sign.processingLeadingPlus(in: result)
      : result

  }

  private func renderWithoutIntegerLength(format: DisplayFormat) -> String {
    Double(self).formatted(
      .number
        .precision(.fractionLength(format.decimalPlaces))
        .grouping(format.grouping)
        .sign(strategy: format.sign.toNativeStrategy)
    )
  }

  private func renderWithIntegerLength(
    _ integerLength: Int,
    format: DisplayFormat
  ) -> String {
    Double(self).formatted(
      .number
        .precision(
          .integerAndFractionLength(
            integer: integerLength,
            fraction: format.decimalPlaces
          )
        )
        .grouping(format.grouping)
    )
  }

  /// `StringRenderable` conformance
  public var toString: String { self.render() }

  /// A convenience that just returns the `displayString()`
  /// method with it's default values
  public var displayString: String { self.render() }
  public var displayStringConcise: String { self.render(using: .short) }
  public var displayStringWithSign: String {
    let format = DisplayFormat(
      decimalPlaces: 2,
      sign: .always(renderPlusSign: false)
    )
    return self.render(using: format)
  }

  /// For backwards compat
  public func displayString(
    places: Int = 2,
    grouping: NumberGrouping = .automatic
  ) -> String {
    render(
      using: DisplayFormat(
        decimalPlaces: places,
        grouping: grouping,
      )
    )
  }
}

extension BinaryFloatingPoint {
  public func toPercentString(within range: ClosedRange<Self>) -> String {
    let percent = Double(toPercent(within: range))
    return String(percent.displayString(places: 0) + "%")
  }
}
