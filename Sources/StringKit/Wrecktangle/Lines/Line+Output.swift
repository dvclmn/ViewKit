//
//  Line+Output.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

import Foundation

extension Box.Line {
  
  func buildStack(
    using engine: Box.Engine,
    startingAt rowIndex: inout Int,
    rowCount: Int,
  ) -> [StringStack] {
    switch body {
      case .text(let content):
        return buildTextLines(content, using: engine, startingAt: &rowIndex)
      case .repeater(let part):
        let pos = Box.PositionContext(i: rowIndex, rowCount: rowCount)
        return buildStructureLine(part, using: engine, at: pos)
    }
  }
  // MARK: - Text Line
  /// Important: This differs to a Structure line, in that it returns
  /// an array (Rows) of lines, due to it handling multiple lines of text.
  ///
  /// Due to this, we give it a mutable row index, so that these nested
  /// lines can update it and give a complete picture of the line count
  private func buildTextLines(
    _ content: String,
    using engine: Box.Engine,
    startingAt rowIndex: inout Int
  ) -> [StringStack] {
    
    let textLines = TextReflow(
      content,
      width: engine.width(for: .text),
    ).reflowed()
    
    let padding = StringStack(
      repeating: " ",
      count: engine.theme.padding.width,
      along: .horizontal
    )
    
    let stacks = textLines.map { line -> StringStack in
      defer { rowIndex += 1 }
      
      let pos = Box.PositionContext(i: rowIndex, rowCount: 0)
      let numbers = StringStack(engine.rowNumbers(for: pos))
      let leading = stack(.leading, using: engine, pos: pos)
      let trailing = stack(.trailing, using: engine, pos: pos)
      let text = StringStack(line)
      
      return .joined(
        numbers,
        leading,
        padding,
        text,
        padding,
        trailing,
        along: .horizontal
      )
    }
    return stacks
  }
}

// MARK: - Structure
extension Box.Line {
  /// This is named `buildBoxLine` to reinforce that this actually
  /// only builds a 'single line' — but a ``Box/LineType`` can
  /// be made up of more than one line of text.
  private func buildStructureLine(
    _ repeater: Box.PartType,
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> [StringStack] {
    
    let leading = stack(.leading, using: engine, pos: position)
    let trailing = stack(.trailing, using: engine, pos: position)
    let repeater = stack(.repeater, using: engine, pos: position, span: .fill)
    let numbers = StringStack(engine.rowNumbers(for: position))
    
    let stack = StringStack.joined(
      numbers,
      leading,
      repeater,
      trailing,
      along: .horizontal
    )
    return [stack]
  }
}

// MARK: - Small helpers
extension Box.Line {
  private func stack(
    _ part: Box.LinePart,
    using engine: Box.Engine,
    pos position: Box.PositionContext,
    span: Box.PartSpan = .single,
  ) -> StringStack {
    
    let linePart: Box.PartType = {
      switch part {
        case .leading: return self.leading
          
        case .repeater:
          guard let repeater = self.body.repeaterValue else {
            fatalError("Do not try to access `LineType.text` for a Structure-type Line.")
          }
          return repeater
        case .trailing: return self.trailing
      }
    }()
    
    return linePart.buildPart(using: engine, pos: position, span: span)
  }
}
