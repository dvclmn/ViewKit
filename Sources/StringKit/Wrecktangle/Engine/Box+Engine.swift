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
  
  func buildString(form components: [any Box.Component]) -> String {
    let allComponents = [Box.Top()] + components + [Box.Bottom()]
    let allLines = allComponents.flatMap { $0.makeLines(using: self) }
    
    let stack =
  }
  
  func buildLines(for type: Box.LineType) -> StringStack {
    switch type {
      case .text(let content, _):
        
//        textLine(
//          content,
//          toWidth: width,
//          using: theme
//        )
//      case .structure(let type):
//        type.line(
//          toWidth: width,
//          using: theme
//        )
//      case .blank: StringStack("")
    }
  }

  func textLines(
    _ content: String,
    lineLimit: Int = 0
  ) -> [Box.LineType] {
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
    let lines = reflowed.map { line in
      textLine(content: line)
    }
    return lines
  }

  func structureLines(
    type: Box.StructureType
  ) -> [Box.LineType] {

    let line =
      switch type {
        case .top: Box.LineType.structure(.top)
        case .divider: Box.LineType.structure(.divider)
        case .bottom: Box.LineType.structure(.bottom)
      }

    return [line]
  }

  public func textLine(
    content: String,
  ) -> StringStack {
    
    return StringStack.joined(
      stack(for: .vertical(.leading)),
      StringStack(content),
      stack(for: .vertical(.trailing)),
      along: .horizontal
    )
  }
  
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
