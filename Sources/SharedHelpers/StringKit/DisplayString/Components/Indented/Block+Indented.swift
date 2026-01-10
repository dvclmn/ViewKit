//
//  Block+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/11/2025.
//

private struct IndentedLineBuilder {
  let indent: String

  mutating func build(from elements: [String]) -> [String] {
    var result: [String] = []
    for (index, element) in elements.enumerated() {
      let isLast = index == elements.count - 1
      let lines = element.lines()
      let prefixChar = (index == 0) ? (isLast ? "└-" : "├-") : (isLast ? "└-" : "├-")
      for (lineIndex, line) in lines.enumerated() {
        if lineIndex == 0 {
          result.append(prefixChar + " " + line)
        } else {
          let continuationChar = isLast ? " " : "│"
          result.append(continuationChar + indent + line)
        }
      }
    }
    return result
  }
}

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
    var builder = IndentedLineBuilder(indent: indent)
    return builder.build(from: content)
  }
}
