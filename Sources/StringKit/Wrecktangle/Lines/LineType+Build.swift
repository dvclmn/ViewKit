//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

// MARK: - String builder for multiple Lines
extension Array where Element == Box.LineType {
  func buildString(using engine: Box.Engine) -> String {
    let lines = self.map { line in
      line.buildString(using: engine)
    }
    return lines.joined(separator: "\n")
  }
}

// MARK: - Main String builder
extension Box.LineType {
  func buildString(
    using engine: Box.Engine
  ) -> String {
    switch self {
      case .text(let line): buildTextLine(line, using: engine)
      case .structure(let type): buildStructureLine(type, using: engine)
    }
  }
}

// MARK: - Helper methods for String Building
extension Box.LineType {

  private func buildStructureLine(
    _ type: Box.StructureType,
    using engine: Box.Engine
  ) -> String {
    let parts = type.parts()

    let stacks = parts.map { part in
      part.buildStack(toWidth: engine.width, using: engine.theme)
    }
    return StringStack.joined(stacks, along: .horizontal).string

  }

  private func buildTextLine(
    _ line: Box.TextLine,
    using engine: Box.Engine
  ) -> String {
    let textContent = TextReflow(
      line.text,
      width: engine.widthForText,
      shouldHyphenate: true
    )
    let reflowed = textContent.reflowed()

    let leading = line.leading.buildStack(
      toWidth: engine.width,
      using: engine.theme
    ).string

    let trailing = line.trailing.buildStack(
      toWidth: engine.width,
      using: engine.theme
    ).string

    let paddingString = String(repeating: " ", count: engine.theme.padding.width)

    let result = reflowed.map { line in
      leading
        + paddingString
        + line
        + paddingString
        + trailing
    }.joined("\n")

    return result

  }
}
