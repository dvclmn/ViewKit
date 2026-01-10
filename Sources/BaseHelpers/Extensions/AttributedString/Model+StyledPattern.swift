//
//  Model+Styled.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation

/// This is a non-Named-Capture type, at least for now.
/// Aka just `Regex<Substring>`, which will
/// return the whole capture, nothing named
///
/// Note: previously had the below defined to catch a
/// whole lot of possible key words for
/// ```
/// /(?<styleTarget>x|y|X|Y|:\s|,\s|W|H|Column|COL|Row|ROW|ROWS|COLS)/
/// ```

public struct StyledPattern {
  public let pattern: Regex<Substring>

  /// For more styles and info, see
  /// `BaseHelpers/Extensions/AttributedString/AttributeContainer`
  public let attributes: AttributeContainer

  public init(_ pattern: Regex<Substring>, attributes: AttributeContainer) {
    self.pattern = pattern
    self.attributes = attributes
  }
}
