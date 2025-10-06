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

public struct StyledThing {
  let patterns: [StyledPattern]
  let sourceText: AttributedString
  //  let sourceText: String

  //  lazy var sourceString: String = {
  //    sourceText.toString
  //  }()

  public init(
    patterns: [StyledPattern],
    sourceText: AttributedString
  ) {
    self.patterns = patterns
    self.sourceText = sourceText
  }

  public init(
    patterns: [StyledPattern],
    sourceText: String
  ) {
    self.init(patterns: patterns, sourceText: AttributedString(sourceText))
  }
}

public struct StyledPattern {
  let pattern: Regex<Substring>

  /// For more styles and info, see
  /// `BaseHelpers/Extensions/AttributedString/AttributeContainer`
  let attributes: AttributeContainer

  public init(_ pattern: Regex<Substring>, attributes: AttributeContainer) {
    self.pattern = pattern
    self.attributes = attributes
  }
}

extension StyledThing {

  public func output() -> AttributedString {
    var result = sourceText
    let string = sourceText.toString
    for style in patterns {
      return string.getAttributed(text: result, matching: style.pattern, attributes: style.attributes)
    }
    return result
  }

  //  private func apply(
  //    runStyle: StyledPattern,
  //    to attributedString: AttributedString
  //  ) -> Attrib {
  //    let
  //    sourceString.getAttributed(
  //      text: attributedString,
  //      matching: runStyle.pattern,
  //      attributes: runStyle.attributes
  //    )
  ////      .findRangesAndApplyAttributes(
  ////      to: &attributedString,
  ////      matching: runStyle.pattern,
  ////      attributes: runStyle.attributes
  ////    )
  //  }
}
