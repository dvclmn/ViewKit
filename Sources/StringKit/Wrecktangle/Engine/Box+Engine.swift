//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

import Foundation

extension Box {
  /// The Builder (aka 'Box Engine') should handle box drawing
  /// based on simple instructions (see ``ViewBox`` and ``HeaderBoxBox``)
  public struct Engine: Codable, Sendable {
    let config: Box.Config
    //    let width: Int
    //
    //    /// Allows dynamic/flexible height, if not defined
    //    let height: Int?
    //
    //    let paddingCharacter: Character
    //    let theme: Box.Theme

    public init(_ config: Box.Config) {
      self.config = config
      //      self.config = Config(w: width, h: height, theme: theme)
      //      self.width = width
      //      self.height = height
      //      self.paddingCharacter = paddingCharacter
    }

    public init(
      width: Int,
      height: Int?,
      theme: Box.Theme,
    ) {
      self.config = Config(w: width, h: height, theme: theme)
      //      self.width = width
      //      self.height = height
      //      self.paddingCharacter = paddingCharacter
    }
  }
}

extension Box.Engine {

  var width: Int { config.width }
  var theme: Box.Theme { config.theme }

  func buildString(from components: [any Box.Component]) -> String {
    let allComponents = [Box.Top()] + components + [Box.Bottom()]
    let allLines = allComponents.flatMap { $0.makeLines(using: self) }

    //    let stack = StringS
  }

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
  /// straight to a String. As the bulk of this
  func textLines(
    _ content: String,
    lineLimit: Int = 0
        ) -> [StringStack] {
//  ) -> [Box.LineType] {
    let text = TextReflow(
      content,
      width: widthForText,
      paddingCharacter: " ",
      shouldHyphenate: true
    )
    let reflowed = text.reflowed(
      maxLines: lineLimit,
      paddingH: config.theme.padding.width
    )
          let stack = Stringst
          
//    let lines = reflowed.map { line in
//      
////      reflowedTextLine(content: line)
//    }
    return lines
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
  func toStack() -> StringStack {
    let lines = self.map { line in
      line.
    }
  }
}
