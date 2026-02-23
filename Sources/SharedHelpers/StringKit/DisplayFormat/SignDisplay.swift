//
//  SignDisplay.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/2/2026.
//

import Foundation

public enum SignDisplay: Sendable, Equatable {
  /// Just displays minus for negative values — the default behvaiour
  case standard

  /// Displays for positive and negative. Choose whether the `+` is visible
  case always(renderPlusSign: Bool = false)

  /// won't display the sign at all, not even minus
  case none

  // MARK: - Formatting helpers

  /// Processes a stringified numeric value according to the sign display rules.
  /// - Parameter value: A numeric value represented as a `String`. Only a leading `+` is considered.
  /// - Returns: The adjusted string where a leading `+` is either replaced by a space (for `.always(renderPlusSign: false)`),
  ///            kept as-is (for `.always(renderPlusSign: true)`), or left unchanged for other cases.
  package func processingLeadingPlus(in value: String) -> String {
    /// Only act on an explicit leading plus sign
    guard let first = value.first, first == "+" else { return value }
    switch self {
      case .always(let renderPlusSign):
        guard renderPlusSign else {
          /// Replace only the first (leading) plus with a space, preserve the rest
          var result = value
          let startIndex = result.startIndex
          result.replaceSubrange(startIndex...startIndex, with: " ")
          return result
        }
        return value
      case .standard, .none:
        /// For these modes, we don't force a plus sign, so just return unchanged
        return value
    }
  }

  package var shouldPostProcess: Bool {
    switch self {
      case .standard, .none: false
      case .always: true
    }
  }

  package var toNativeStrategy: FloatingPointFormatStyle<Double>.Configuration.SignDisplayStrategy {
    switch self {
      case .standard: .automatic
      case .always: .always(includingZero: true)
      case .none: .never
    }
  }
}
