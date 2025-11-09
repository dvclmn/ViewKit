//
//  Box+Line.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box {

  /// Curious to see whether I *need* `LineType` to
  /// fully express all the stuff, or whether I can just construct
  /// any Line based on any parts, given a StringStack-based
  /// approach, rather than PartType / String mix

  /// This is strictly a Three-Part Line. Will need to introduce
  /// a new type/system to support e.g. multi-column Boxes
  public struct Line {
    
    let engine: Box.Engine
    
    let leading: PartType
    let body: LineType
    let trailing: PartType

    /// Init for Text Line
    public init(
      _ textContent: String,
      leading: PartType,
      trailing: PartType,
      using engine: Box.Engine
    ) {
      self.leading = leading
      self.body = .text(textContent)
      self.trailing = trailing
      self.engine = engine
    }

    public init(
      _ repeater: PartType,
      leading: PartType,
      trailing: PartType,
      using engine: Box.Engine
    ) {
      self.leading = leading
      self.body = .repeater(repeater)
      self.trailing = trailing
      self.engine = engine
    }
  }
}

extension Box.Line {

  func buildStack(
    using engine: Box.Engine,
    startingAt rowIndex: inout Int,
    rowCount: Int
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

    var stacks: [StringStack] = []

    for textLine in textLines {
      let pos = Box.PositionContext(i: rowIndex, rowCount: 0)
      rowIndex += 1

      let numbers = StringStack(engine.rowNumbers(for: pos))

      let leading = leading.buildPart(using: engine, pos: pos)
      let trailing = trailing.buildPart(using: engine, pos: pos)

      let padding = StringStack(
        repeating: " ",
        count: engine.theme.padding.width,
        along: .horizontal
      )
      let stackText = StringStack(textLine)

      let lineStack = StringStack.joined(
        numbers,
        leading,
        padding,
        stackText,
        padding,
        trailing,
        along: .horizontal
      )
      stacks.append(lineStack)
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

    let lead = leading.buildPart(using: engine, pos: position)
    let trail = trailing.buildPart(using: engine, pos: position)
    let repeated = repeater.buildPart(
      using: engine,
      pos: position,
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
    return [stack]
  }
}

// MARK: - Small helpers
extension Box.Line {
  private func stack(
    for type: Box.PartType
  ) -> StringStack {
    type.buildPart(using: <#T##Box.Engine#>, pos: <#T##Box.PositionContext#>, span: <#T##Box.PartSpan#>)
  }
}

extension Box.Line: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      body.description
      leading.description
      trailing.description
    }.plainText
  }
}
