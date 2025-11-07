//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

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
    
    return StringStack.joined(
      numbers,
      lead,
      repeated,
      trail,
      along: .horizontal
    ).string
  }
}

// MARK: - Text
extension Box.TextLine {
  func buildLine(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {

    let lead = leading.buildPart(using: engine, position: position)
    let trail = trailing.buildPart(using: engine, position: position)

    let numbers = StringStack(engine.rowNumbers(for: position))
    
    let paddingCount = engine.theme.padding.width
    let padding = StringStack(repeating: " ", count: paddingCount, along: .horizontal)
//    let padding = String(repeating: " ", count: paddingCount)

    let textContent = TextReflow(
      text,
      width: engine.width(for: .text),
      shouldHyphenate: true
    ).reflowed()
    
    let textLineStack = StringStack(textContent)

    return StringStack.joined(
      numbers,
      lead,
      padding,
      textLineStack,
//      padding,
      trail,
      along: .horizontal
    ).string
//    let numbersIfNeeded: String = hasRowNumbers ? "\(position.rowNumber) " : ""

//    return textContent.reflowed().map { line in
//      "&%" + lead + padding + line + padding + trail
//      numbersIfNeeded + lead + padding + line + padding + trail
//    }.joined("\n")
  }
}
