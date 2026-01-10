//
//  NSRange+Preview.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/1/2026.
//

import AppKit

extension NSRange {

  public func debugPreview(
    in text: String,
    maxRangePreviewLength: Int? = nil,
    maxContextLength: Int = 30,
    indentCharacter: Character = "│",
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {
    guard let stringRange = toStringRange(in: text) else {
      return "Unable to convert NSRange to Range<String.Index>"
    }
    return stringRange.debugPreview(
      in: text,
      maxRangePreviewLength: maxRangePreviewLength,
      maxContextLength: maxContextLength,
      indentCharacter: indentCharacter,
      highlight: highlight
    )
  }
}
