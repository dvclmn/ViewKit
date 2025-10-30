//
//  DisplayBlock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import EnumMacros
import Foundation
import SharedHelpers

@CaseDetection(includesNames: true)
public enum DisplayBlock {
  case text(StyledString)
  case indented(Indented)
  //  case indented(title: String?, indent: String, content: [DisplayBlock])

  var indentationDepth: Int {
    switch self {
      case .text: return 0
      case .indented(let indented):
        return 1 + (indented.content.map(\.indentationDepth).max() ?? 0)
    }
  }
}

extension DisplayBlock: StyledStringConvertible {

  private func indentedElements(
    _ indent: String,
    content: [StyledString]
  ) -> [StyledString] {

    /// Indent each element, handling multi-line content
    let indented = content.flatMap { element -> [StyledString] in
      let lines = element.splitByNewlines()

      /// Handle the edge case of an empty element gracefully.
      guard let firstLine = lines.first else { return [StyledString("")] }

      /// Take the rest of the lines...
      let subsequentLines = lines.dropFirst()

      /// ...and map over them to add the indent.
      let indentedSubsequentLines = subsequentLines.map { line in
        StyledString(indent, with: .blackOnGreen) + line
      }

      /// Recombine the first line with the now-indented subsequent lines.
      return [firstLine] + indentedSubsequentLines
    }
    return indented
  }

  public var toStyledString: StyledString {
    switch self {
      case .text(let styledString):
        return styledString

      case .indented(let indented):

        /// Convert all content to styled strings first
        let convertedContent = indented.content.map { $0.toStyledString }
        let indentedElements = indentedElements(indented.indentString, content: convertedContent)

        /// Join elements, making sure to indent between
        guard !indentedElements.isEmpty else {
          return StyledString("$", with: .highlighter)
        }

        var result = indentedElements[0]

        for element in indentedElements.dropFirst() {
          /// If element doesn't start with indent, add it
          let hasIndent = element.plainString.hasPrefix(indented.indentString)
          if !hasIndent {
            result = result + StyledString("\n" + indented.indentString, with: .blackOnOrange) + element
          } else {
            result = result + StyledString("\n") + element
          }
        }

        /// Add title if present
        if let title = indented.title {
          return StyledString(title + "\n") + result
        }

        return result
    }
  }

}
