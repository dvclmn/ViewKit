//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import Foundation

extension Box {

  public struct Engine: Codable, Sendable {
    let config: Box.Config

    public init(_ config: Box.Config) {
      self.config = config
    }

    public init(
      width: Int,
      height: Int?,
      theme: Box.Theme,
    ) {
      self.config = Config(w: width, h: height, theme: theme)
    }
  }
}

extension Box.Engine {
  var width: Int { config.width }
  var theme: Box.Theme { config.theme }
}

extension Box.Engine {
  //  func buildString(from components: [any Box.Component]) -> String {
  //    let allComponents = [Box.Top()] + components + [Box.Bottom()]
  //    let allLines = allComponents.flatMap { $0.makeLines(using: self) }
  //
  //    //    let stack = StringS
  //  }

  //  func buildLines(for type: Box.LineType) -> StringStack {
  //    switch type {
  //      case .text(let content, _):
  //
  //      case .structure(let type):
  //      case .blank:
  ////        textLine(
  ////          content,
  ////          toWidth: width,
  ////          using: theme
  ////        )
  ////      case .structure(let type):
  ////        type.line(
  ////          toWidth: width,
  ////          using: theme
  ////        )
  ////      case .blank: StringStack("")
  //    }
  //  }

  /// I think for text lines, we may actually want to go
  /// straight to a `[String]`. As the bulk of this

  /// This should go from `[Box.LineType]` to String?
  func textLine(_ content: String) -> Box.LineType {
    let textLine = Box.TextLine(
      leading: .vertical(.leading),
      text: content,
      trailing: .vertical(.trailing)
    )
    return Box.LineType.text(textLine)
    //    let leadingCap = Box.PartType.vertical(.leading)
    //      .glyphStack(with: config.theme.frameStyle)
    //    let traliingCap = Box.PartType.vertical(.trailing)
    //      .glyphStack(with: config.theme.frameStyle)

    //    return []

    //          let stack = Stringst

    //    let lines = reflowed.map { line in
    //
    ////      reflowedTextLine(content: line)
    //    }
    //    return lines
  }

  func reflow() {

  }

  func validateTextCap(cap: Box.GlyphStack) {
    precondition(
      cap.count == 1,
      "A text content cap should not exceed 1 character in height"
    )
  }

  func structureLine(
    type: Box.StructureType
  ) -> Box.LineType {

    let line =
      switch type {
        case .top: Box.LineType.structure(.top)
        case .divider: Box.LineType.structure(.divider)
        case .bottom: Box.LineType.structure(.bottom)
      }

    return line
  }

  /// Important: a Text Line cannot exceed a height of 1 character.
  /// This is simply to facilitate the natural flow/behaviour of text, for reading.
  public func reflowedTextLine(
    content: String,
  ) -> Box.LineType {
    //  ) -> StringStack {
    //    return .text(content: content, lineLimit: 0)

  }

  //  func stack(for line: Box.LineType) -> StringStack {
  //    switch line {
  //      case .text(let content, _):
  //        textLines(content)
  //
  //      case .structure(let structureType):
  //        <#code#>
  //      case .blank:
  //        <#code#>
  //    }
  ////    guard part.flexibility.isRepeatable else {
  ////      let stack = part.glyphStack(with: theme.frameStyle)
  ////      return StringStack(from: stack, with: theme)
  ////    }
  ////
  ////    let stack = part.glyphStack(with: theme.frameStyle)
  ////    let stringStack = StringStack(from: stack, with: theme)
  ////    let repeated = stringStack.repeated(along: .horizontal, count: width - theme.padding.width * 2)
  ////    return repeated
  //  }

  func stack(for part: Box.PartType) -> StringStack {

    guard part.flexibility.isRepeatable else {
      let stack = part.glyphStack(with: theme.frameStyle)
      return StringStack(from: stack, with: theme)
    }

    let stack = part.glyphStack(with: theme.frameStyle)
    let stringStack = StringStack(from: stack, with: theme)
    let repeated = stringStack.repeated(along: .horizontal, count: width - theme.padding.width * 2)
    return repeated
  }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = config.theme.frameStyle.reservedDimensions.width
    let finalWidth = max(0, config.width - capCount)
    //    print("Width for text: \(finalWidth)")
    return finalWidth
  }

  public var heightForText: Int? {
    guard let height = config.height else { return nil }
    let capCount = config.theme.frameStyle.reservedDimensions.height
    return max(0, height - capCount)
  }
}

extension Array where Element == Box.LineType {
  func buildString(using engine: Box.Engine) -> String {
    let lines = self.map { line in
      line.buildString(using: engine)
    }
    return lines.joined(separator: "\n")
    //    let lines = self.map { line in
    //      line.
    //    }
  }
}

extension Box.LineType {
  func buildString(
    using engine: Box.Engine
  ) -> String {
    switch self {
      case .text(let line):
        let textContent = TextReflow(
          line.text,
          width: engine.widthForText,
          paddingCharacter: " ",
          shouldHyphenate: true
        )
        let reflowed = textContent.reflowed(
          paddingH: engine.config.theme.padding.width
        )
        let leading = line.leading.toString(with: engine.theme)
        let trailing = line.trailing.toString(with: engine.theme)
        //        let lead = line.leading.glyphStack(with: engine.theme.frameStyle)
        //        let leadString = StringStack(from: lead, with: engine.theme).string

        //        let result = reflowed.map { textLine in
        //          leading + textLine + trailing
        //        }
        let result = reflowed.reduce(into: "") { partialResult, textLine in
          partialResult += leading + textLine + trailing
        }

        return result

      case .structure(let structureType):
        <#code#>
      case .blank:
        <#code#>
    }
  }
}
