//
//  Line+Output.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

import Foundation
import SharedHelpers

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
      repeating: StringStack(unicodeScalarLiteral: Box.paddingCharacterFallback),
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

  // MARK: - Structure

  /// This is named `buildBoxLine` to reinforce that this actually
  /// only builds a 'single line' — but a ``Box/LineType`` can
  /// be made up of more than one line of text.
  private func buildStructureLine(
    _ repeater: Box.PartRole,
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

  // MARK: - Small helpers
  private func stack(
    _ segment: Box.LineSegment,
    using engine: Box.Engine,
    pos position: Box.PositionContext,
    span: Box.PartSpan = .single,
  ) -> StringStack {

    switch segment {
      case .leading:
        return Box.Line.resolvedPart(leading, using: engine, at: position)
      case .repeater:

        switch self.body {
          case .repeater(let part):
            return Box.Line.resolvedPart(part, repeated: engine.width(for: .repeatedPart), using: engine, at: position)
          case .text(_): fatalError("Do not try to access `LineType.repeater` for a Text-type Line.")
        }

      case .trailing:
        return Box.Line.resolvedPart(trailing, using: engine, at: position)
    }
  }
}

extension Box.Line {
  static func resolvedPart(
    _ part: LinePart,
    repeated count: Int? = nil,
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> StringStack {
    let structure = part.part(using: engine, position: position)
    
    let resolved = structure.resolved(with: engine.glyphDesign)

    if engine.theme.frameStyle.isDouble && structure.role.isHorizontal {
      print(
        "---\nPart Original: \(structure)",
        "\nPart Resolved: \(resolved.prettyDescription)",
        "\n---\n\n"
      )
      
    }
    
    let stack = resolved.toStringStack(with: engine.theme)
    guard let count else {
      return stack
    }
    return StringStack(repeating: stack, count: count, along: .horizontal)
  }
}
