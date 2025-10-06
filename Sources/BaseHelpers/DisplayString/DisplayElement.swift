//
//  DisplayElement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import Foundation

public enum DisplayElement {
  case text(StyledString)
  case indented(title: String?, indent: String, content: [DisplayElement])

  var indentationDepth: Int {
    switch self {
      case .text: return 0
      case .indented(_, _, let content):
        return 1 + (content.map(\.indentationDepth).max() ?? 0)
    }
  }
}

extension DisplayElement: StyledStringConvertible {
  
  public var toStyledString: StyledString {
    switch self {
      case .text(let styledString):
        return styledString

      case .indented(let title, let indent, let content):
        // Convert all content to styled strings first
        let convertedContent = content.map { $0.toStyledString }

        // Indent each element properly, handling multi-line content
        let indentedElements = convertedContent.flatMap { element -> [StyledString] in
          let lines = element.splitByNewlines()
          guard !lines.isEmpty else { return [StyledString("")] }

          // Indent each line except the first one gets special handling
          // when joining multiple elements
          return lines.enumerated().map { index, line in
            index == 0 ? line : StyledString(indent) + line
          }
        }

        // Join elements, making sure to indent between elements
        guard !indentedElements.isEmpty else {
          return StyledString("")
        }

        var result = indentedElements[0]
        for element in indentedElements.dropFirst() {
          // If element doesn't start with indent, add it
          if !element.plainString.hasPrefix(indent) {
            result = result + StyledString("\n" + indent) + element
          } else {
            result = result + StyledString("\n") + element
          }
        }

        // Add title if present
        if let title = title {
          return StyledString(title + "\n") + result
        }

        return result
    }
  }
}
