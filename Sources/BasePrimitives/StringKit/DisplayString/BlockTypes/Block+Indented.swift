//
//  Model+Indented.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/10/2025.
//

import Foundation

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
