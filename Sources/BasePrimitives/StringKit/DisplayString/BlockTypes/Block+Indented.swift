//
//  Model+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

/// When `Indented` has it's own `buildExpression`, conformance
/// to `StyledStringConvertible` is not needed nor read
public struct Indented: Sendable {
  public let title: String?
  public let content: [DisplayBlock]
}

extension Indented {
  public init(
    _ title: String? = nil,
    @DisplayStringBuilder content: () -> [DisplayBlock]
  ) {
    self.title = title
    self.content = content()
  }

  init(fromLines indentedLines: IndentedLines) {
    let blocks: [DisplayBlock] = indentedLines.lines.map {
      DisplayBlock.text(DisplayFragment($0))
    }
    self.init(title: indentedLines.title, content: blocks)
  }
  //extension Indented: DisplayRenderable {

  public func render(
    labelStyle: AbbreviableLabel.Style = .standard,
    using format: FloatDisplayFormat
  ) -> String {

    let content = content.map {
      $0.render(labelStyle: labelStyle, using: format)
    }
    let elements = indentedElements(content: content)

    let result = elements.reduce(into: "") { partial, item in
      partial += "\n" + item
    }
    /// Add title if present, and a final line break
    return (title ?? "") + result + "\n"
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

private struct IndentedLineBuilder {
  let indent: String

  /// Hard coded for now
  let glyphStyle: IndentGlyphStyle = .rounded

  mutating func build(from elements: [String]) -> [String] {
    var result: [String] = []
    for (index, element) in elements.enumerated() {
      let isLast = index == elements.count - 1
      let lines = element.lines()
      let prefixChar = (index == 0) ? (isLast ? "└─" : "├─") : (isLast ? "└─" : "├─")
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

enum IndentGlyphStyle {
  case standard
  case rounded

  var glyphs: IndentGlyphs {
    switch self {
      case .standard:
        IndentGlyphs(
          corner: "└",
          join: "├",
          horizontal: "─",
          vertical: "│"
        )
      case .rounded:
        IndentGlyphs(
          corner: "╰",
          join: "├",
          horizontal: "─",
          vertical: "│"
        )
    }
  }

}

struct IndentGlyphs {
  let corner: Character
  let join: Character
  let horizontal: Character
  let vertical: Character
}
