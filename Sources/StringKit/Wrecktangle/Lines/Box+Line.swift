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
//  public struct Line {
//    let leading: PartType
//    let body: ContentPart
//    let trailing: PartType
//
//    /// Init for Text Line
//    public init(
//      _ textContent: String,
//      leading: PartType,
//      trailing: PartType
//    ) {
//      self.leading = leading
//      self.body = .text(textContent)
//      self.trailing = trailing
//    }
//
//    public init(
//      _ repeater: PartType,
//      leading: PartType,
//      trailing: PartType
//    ) {
//      self.leading = leading
//      self.body = .customPart(repeater)
//      self.trailing = trailing
//    }
//  }
}

extension Box.Line {

  public func build(
    using engine: Box.Engine,
    startingAt rowIndex: inout Int,
    rowCount: Int
  ) -> [StringStack] {
    switch body {
      case .text(let content):
        buildTextLines(
          content,
          using: engine,
          startingAt: &rowIndex
        )
      //        buildTextLines(content, using: engine, startingAt: &rowIndex)
      case .structure(let part):
        buildStructureLine(
          part,
          using: engine,
          at: .init(i: rowIndex, rowCount: rowCount)
        )
    }
  }
  // MARK: - Text Line
  /// Important: This differs to a Structure line, in that it returns
  /// an array (Rows) of lines, due to it handling multiple lines of text.
  private func buildTextLines(
    _ content: String,
    using engine: Box.Engine,
    //    at position: Box.PositionContext
    startingAt rowIndex: inout Int
  ) -> [StringStack] {

    let textLines = TextReflow(
      content,
      width: engine.width(for: .text),
      shouldHyphenate: true
    ).reflowed()

    var stacks: [StringStack] = []

    for textLine in textLines {
      let pos = Box.PositionContext(i: rowIndex, rowCount: 0)
      rowIndex += 1

      let numbers = StringStack(engine.rowNumbers(for: pos))

      let leading = Box.PartType.vertical(.leading)
        .buildPart(using: engine, position: pos)
      let trailing = Box.PartType.vertical(.trailing)
        .buildPart(using: engine, position: pos)
      //      let lead = leading.buildPart(using: engine, position: pos)
      //      let trail = trailing.buildPart(using: engine, position: pos)
      //      let trail = trailing.buildPart(using: engine, position: pos)

      let padding = StringStack(repeating: " ", count: engine.theme.padding.width, along: .horizontal)
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

    let lead = leading.buildPart(using: engine, position: position)
    let trail = trailing.buildPart(using: engine, position: position)
    let repeated = repeater.buildPart(
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

    return [stack]

  }
}
