//
//  DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/7/2025.
//

import SwiftUI

public typealias NumberGrouping = FloatingPointFormatStyle<Double>.Configuration.Grouping

public protocol FloatRenderable: BinaryFloatingPoint, DisplayAtomRenderable, DisplayPresetRenderable {
//public protocol FloatRenderable: BinaryFloatingPoint, DisplayStringRenderable {
  func render(using format: FloatDisplayFormat) -> String
}

extension FloatRenderable {
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    render(using: preset.format)
  }
  
}

/// This protocol combo is unlikely to exist, but just in case
extension FloatRenderable where Self: PropertiesLabeled {
  public var displayString: String {
    renderProperties(using: .default)
  }
  public func displayString(_ preset: FloatDisplayPreset) -> String {
    renderProperties(using: preset.format)
  }
}

extension Double: FloatRenderable {}
extension CGFloat: FloatRenderable {}
extension Float: FloatRenderable {}

extension FloatRenderable {
  public func render(using format: FloatDisplayFormat = .default) -> String {

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

  private func renderWithoutIntegerLength(format: FloatDisplayFormat) -> String {
    Double(self).formatted(
      .number
        .precision(.fractionLength(format.decimalPlaces))
        .grouping(format.grouping)
        .sign(strategy: format.sign.toNativeStrategy)
    )
  }

  private func renderWithIntegerLength(
    _ integerLength: Int,
    format: FloatDisplayFormat
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

}
