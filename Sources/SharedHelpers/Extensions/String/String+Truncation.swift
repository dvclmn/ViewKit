//
//  String+Truncation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import Foundation

public enum TruncationStyle {
  case start  // "...end"
  case middle  // "begin...end"
  case end  // "begin..."
}

extension String {
  /// Truncates a string to a maximum length using the specified truncation style.
  /// The ellipsis ("...") does not count toward the maxLength.
  ///
  /// Examples:
  /// - "Hello World".truncate(to: 8, style: .middle) → "Hell...orld"
  /// - "Hello World".truncate(to: 8, style: .end) → "Hello..."
  /// - "Hello World".truncate(to: 8, style: .start) → "...World"
  /// - "Short".truncate(to: 10) → "Short" (unchanged)
  /// - "".truncate(to: 10) → "(Empty)"
  ///
  /// - Parameters:
  ///   - maxLength: Maximum number of content characters to show (ellipsis not counted, minimum 2)
  ///   - style: The truncation style (.start, .middle, or .end)
  ///   - emptyPlaceholder: Text to show when the string is empty
  /// - Returns: Truncated string with ellipsis, or original string if shorter than maxLength
  public func truncate(
    to maxLength: Int = 20,
    ellipsis: String = "…",
    style: TruncationStyle = .middle,
    emptyPlaceholder: String? = "(Empty)"
  ) -> String {

    /// Handle empty string
    guard !self.isEmpty else { return emptyPlaceholder ?? self }

    /// Ensure minimum length for meaningful truncation
    let minLength = 2
    let effectiveMaxLength = max(minLength, maxLength)

    /// If string is short enough, return as-is
    guard self.count > effectiveMaxLength else { return self }

    switch style {
      case .start:
        let suffix = String(self.suffix(effectiveMaxLength))
        return "\(ellipsis)\(suffix)"

      case .middle:
        let prefixLength = effectiveMaxLength / 2
        let suffixLength = effectiveMaxLength - prefixLength
        let prefix = String(self.prefix(prefixLength))
        let suffix = String(self.suffix(suffixLength))
        return "\(prefix)\(ellipsis)\(suffix)"

      case .end:
        let prefix = String(self.prefix(effectiveMaxLength))
        return "\(prefix)\(ellipsis)"
    }
  }

  /// Wraps text in decorative dividers for display purposes
  public func wrappedInDividers() -> String {
    return "\n---\n\(self)\n---\n"
  }
}
