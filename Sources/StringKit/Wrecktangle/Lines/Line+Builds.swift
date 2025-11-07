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
  /// This is named `buildBoxLine` to reinforce that this actually
  /// only builds a 'single line' — but a ``Box/LineType`` can
  /// be made up of more than one line of text.
  func buildBoxLine(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> StringStack {

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

//    print("Structure stack:\n\(stack.debugDescription)\n\n")

    return stack

  }
}

// MARK: - Text
extension Box.TextLine {
  /// Important: This differs to a Structure line, in that it returns
  /// an array (Rows) of lines, due to it handling multiple lines of text.
  func buildLines(
    using engine: Box.Engine,
//    at position: Box.PositionContext
    startingAt rowIndex: inout Int
  ) -> [StringStack] {

    let textLines = TextReflow(
      text,
      width: engine.width(for: .text),
      shouldHyphenate: true
    ).reflowed()
    
    var stacks: [StringStack] = []
    
    for textLine in textLines {
      let pos = Box.PositionContext(i: rowIndex, rowCount: 0)
      rowIndex += 1
      
      let numbers = StringStack(engine.rowNumbers(for: pos))
      let lead = leading.buildPart(using: engine, position: pos)
      let trail = trailing.buildPart(using: engine, position: pos)
      let padding = StringStack(repeating: " ", count: engine.theme.padding.width, along: .horizontal)
      let stackText = StringStack(textLine)
      
      let lineStack = StringStack.joined(
        numbers,
        lead,
        padding,
        stackText,
        padding,
        trail,
        along: .horizontal
      )
      stacks.append(lineStack)
    }
    
    return stacks
    
//    let lead = leading.buildPart(using: engine, position: position)
//    let trail = trailing.buildPart(using: engine, position: position)
//
//    let numbers = StringStack(engine.rowNumbers(for: position))
//
//    let paddingCount = engine.theme.padding.width
//    let padding = StringStack(repeating: " ", count: paddingCount, along: .horizontal)
//
//    let textLines: [String] = TextReflow(
//      text,
//      width: engine.width(for: .text),
//      shouldHyphenate: true
//    ).reflowed()
//
//    let lines: [StringStack] = textLines.map { textLine in
//      let stackText = StringStack(textLine)
//      return StringStack.joined(
//        numbers,
//        lead,
//        padding,
//        stackText,
//        padding,
//        trail,
//        along: .horizontal
//      )
//    }
//
//    let stack = StringStack.joined(lines, along: .vertical)
//    return stack
  }
}
