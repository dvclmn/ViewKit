//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation
import SharedHelpers

// MARK: - Structure
extension Box.StructureLine {
  func buildLine(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {

    let lead = leading.buildPart(using: engine, position: position)
    let trail = trailing.buildPart(using: engine, position: position)
    let repeated = repeating.buildPart(
      using: engine,
      position: position,
      span: .fill
    )
    let numbers = StringStack(engine.rowNumbers(for: position))
    
    let stack = StringStack.joined(
      numbers,
      lead,
      repeated,
      trail,
      along: .horizontal
    )
    
    print("Structure stack:\n\(stack.debugDescription)\n\n")
    
    return stack.string
    
  }
}

// MARK: - Text
extension Box.TextLine {
  /// Important: This differs to a Structure line, in that it returns
  /// an array (Rows) of lines, due to it handling multiple lines of text.
  func buildLines(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> [String] {

    let lead = leading.buildPart(using: engine, position: position)
    let trail = trailing.buildPart(using: engine, position: position)

    let numbers = StringStack(engine.rowNumbers(for: position))
    
    let paddingCount = engine.theme.padding.width
    let padding = StringStack(repeating: " ", count: paddingCount, along: .horizontal)
//    let padding = String(repeating: " ", count: paddingCount)

    let textLines = TextReflow(
      text,
      width: engine.width(for: .text),
      shouldHyphenate: true
    ).reflowed()
    
    let rows = textLines.map { line in
      let textLine = StringStack(line)
      return StringStack.joined(
        numbers,
        lead,
        padding,
        textLine,
        padding,
        trail,
        along: .horizontal
      ).string
    }
    
    return rows
    
//    print("Text line stack:\n\(textLineStack.string)\n\n\n")

    
//    let numbersIfNeeded: String = hasRowNumbers ? "\(position.rowNumber) " : ""

//    return textContent.reflowed().map { line in
//      "&%" + lead + padding + line + padding + trail
//      numbersIfNeeded + lead + padding + line + padding + trail
//    }.joined("\n")
  }
}
