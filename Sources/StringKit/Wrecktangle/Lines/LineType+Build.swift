//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

// MARK: - Main String builder
extension Box.LineType {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    switch self {
      case .structure(let type):
        return type.parts.buildString(using: engine, at: position)
      case .text(let line):
        return line.buildString(using: engine, at: position)
    }
  }
//  func buildString(
//    using engine: Box.Engine
//  ) -> String {
//    switch self {
//      case .text(let line): buildTextLine(line, using: engine)
//      case .structure(let type): buildStructureLine(type, using: engine)
//    }
//  }
}

// MARK: - Helper methods for String Building
//extension Box.LineType {
//
//  private func buildStructureLine(
//    _ type: Box.StructureType,
//    using engine: Box.Engine
//  ) -> String {
//    let parts = type.parts
//    return parts.buildParts(using: engine)
//  }
//
//  private func buildTextLine(
//    _ line: Box.TextLine,
//    using engine: Box.Engine
//  ) -> String {
//
//    /// Build caps
//    let leading = line.leading.buildPart(
//      with: engine.theme,
//      repeatCount: 1
//    ).string
//    let trailing = line.trailing.buildPart(
//      with: engine.theme,
//      repeatCount: 1
//    ).string
//
//    /// Reflow Text
//    let textContent = TextReflow(
//      line.text,
//      width: engine.widthForText,
//      shouldHyphenate: true
//    )
//    let reflowed = textContent.reflowed()
//
//    /// Set up Padding
//    let paddingCount = engine.theme.padding.width
//    let paddingString = String(repeating: " ", count: paddingCount)
//
//    let result = reflowed.map { line in
//      leading
//        + paddingString
//        + line
//        + paddingString
//        + trailing
//    }.joined("\n")
//
//    return result
//
//  }
//}

// MARK: - String builder for multiple Lines
extension Array where Element == Box.LineType {
  func buildString(using engine: Box.Engine, at position: Box.PositionContext) -> String {
    let lines = self.map { line in
      line.buildString(using: engine, at: position)
    }
    return lines.joined("\n")
  }
}
