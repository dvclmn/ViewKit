//
//  Env+ValueFormatting.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/3/2026.
//

import SwiftUI

// MARK: - Value formatting
extension EnvironmentValues {

  @Entry public var formatValue: (Double) -> String = { $0.displayString }

  /// E.g. 3 places: `10.056` or one place: `10.1`
  /// See `Foundation/NumberFormatStyleConfiguration/Precision`
  /// This imposes a fixed number (no min or max) of places.
  @Entry public var fractionLength: Int?

  /// E.g. 3 places: `023.6` or two places: `23.6`
  /// As implied in the name, this won't impose an upper limit,
  /// only ensure there are at least 'x' integers
  @Entry public var minIntegerLength: Int?

  /// App-wide / project-wide mapping convention, for which
  /// property on a type should be considered the identity vs transposed.
  /// Aka whether width maps to horizontal, or rows to vertical, etc etc.
  /// See ``AxisAddressable``
  @Entry public var axisMapping: AxisMapping = .identity

}

public protocol ValueFormattable {}

extension View where Self: ValueFormattable {
  public func formatValue(_ format: @escaping (Double) -> String) -> some View {
    self.environment(\.formatValue, format)
  }

  public func formatValue(_ preset: FloatDisplayPreset) -> some View {
    self.environment(\.formatValue, { $0.displayString(preset) })
  }
}
