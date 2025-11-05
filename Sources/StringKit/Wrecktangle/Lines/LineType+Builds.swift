//
//  LineType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

// MARK: - Structure
extension Box.StructureLine {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    
    let lead = leading.buildPart(using: engine, position: position)
    let trail = trailing.buildPart(using: engine, position: position)
    let repeated = repeating.buildPart(
      using: engine,
      position: position,
      repeating: engine.repeatedPartWidth
    )
    
    return StringStack.joined(
      StringStack(position.rowNumber.toString),
      lead,
      repeated,
      trail,
      along: .horizontal
    ).string
  }
}

// MARK: - Text
extension Box.TextLine {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    
    let hasRowNumbers = engine.config.hasRowNumbers

    let lead = leading.buildPart(using: engine, position: position).string
    let trail = trailing.buildPart(using: engine, position: position).string
    
    let paddingCount = engine.theme.padding.width
    let padding = String(repeating: " ", count: paddingCount)
    
    let textContent = TextReflow(
      text,
      width: engine.widthForText,
      shouldHyphenate: true
    )
    
    let numbersIfNeeded: String = hasRowNumbers ? "\(position.rowNumber) " : ""
    
    return textContent.reflowed().map { line in
      numbersIfNeeded + lead + padding + line + padding + trail
    }.joined("\n")
  }
}
