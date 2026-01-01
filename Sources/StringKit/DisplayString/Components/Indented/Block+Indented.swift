//
//  Block+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

extension DisplayBlock {

  func createIndented(for indented: Indented) -> String? {
    guard !indented.content.isEmpty else { return nil }

    let content = indented.content.compactMap(\.toString)
    let indentedElements = indentedElements(content: content)

    let result = indentedElements.reduce(into: "") { partial, item in
      partial += "\n" + item
    }

    /// Add title if present
    return (indented.title ?? "") + result
  }

  private func indentedElements(
    content: [String],
    indent: String = "  ",
    isLastElement: Bool = false
  ) -> [String] {

    var result: [String] = []

    for (index, element) in content.enumerated() {
      let isLast = index == content.count - 1
      let lines = element.lines()

      /// Choose the appropriate prefix character
      let prefixChar: String
      if index == 0 {
        prefixChar = isLastElement ? "└" : "├"
      } else {
        prefixChar = isLast ? "└" : "├"
      }

      for (lineIndex, line) in lines.enumerated() {
        processLine(
          line,
          at: lineIndex,
          isLast: isLast,
          prefixChar: prefixChar,
          result: &result
        )
      }

    }

    return result
  }

  private func processLine(
    _ line: String,
    at index: Int,
    isLast: Bool,
    prefixChar: String,
    result: inout [String]
  ) {
    if index == 0 {
      /// First line of element
      let prefix = prefixChar + " "
      result.append(prefix + line)
    } else {
      /// Subsequent lines - use vertical line or space for continuation
      let continuationChar = isLast ? " " : "│"
      let prefix = StyledString(continuationChar + indent, with: .blackOnGreen)
      result.append(prefix + line)
    }
  }
}
