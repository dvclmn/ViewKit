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
/// This little domain is basically attempting to identify common patterns
/// in bits of UI throughout my apps. And then assign meaning and
/// regex patterns to them, to automatically highlight them according
/// to their purpose etc.

public struct StyledKeywords {
  /// Will need to determine a way for the regex to know what is
  /// a keyword, and what is just a normal letter in a sentence etc.
  public static let keyWords: [String] = [
    "x", "y",
    "X", "Y",
    "w", "h",
    "W", "H",
    
    ":", ",",

    "Row", "ROW",
    "Rows", "ROWS",

    "Column", "COL",
    "Columns", "COLS",

  ]
}

//public struct StyledPattern {
//  public let pattern: Regex<Substring>
//
//  /// For more styles and info, see
//  /// `BaseHelpers/Extensions/AttributedString/AttributeContainer`
//  public let attributes: AttributeContainer
//
//  public init(_ pattern: Regex<Substring>, attributes: AttributeContainer) {
//    self.pattern = pattern
//    self.attributes = attributes
//  }
//}
