//
//  BoxLine+Text.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//


extension Box.Line {
  static func textLine(
    _ text: String,
    theme: Box.Theme,
    totalWidth: Int
  ) -> Line {
    let leading = Box.PartType.vertical(.leading).build(using: theme)
    let trailing = Box.PartType.vertical(.trailing).build(using: theme)
    let availableForText = max(0, totalWidth - (leading.width + trailing.width))
    
    // Create the text Part.
    let textRow = Array(text.prefix(availableForText))
    let stringStack = StringStack([textRow])
    let textPart = Box.Part(type: .blank, stringStack: stringStack)
    
    return Line(leading: leading, body: textPart, trailing: trailing)
  }

  static func structureLine(
    _ structure: Box.PartType,
    theme: Box.Theme,
    width: Int
  ) -> Line {
    let leading = Box.PartType.corner(.topLeading).build(using: theme)
    let body = structure.build(using: theme)
    let trailing = Box.PartType.corner(.topTrailing).build(using: theme)
    return Line(leading: leading, body: body, trailing: trailing)
  }
  
  static func blank(
    theme: Box.Theme,
    totalWidth: Int
  ) -> Line {
    let leading = Box.PartType.vertical(.leading).build(using: theme)
    let trailing = Box.PartType.vertical(.trailing).build(using: theme)
    let available = max(0, totalWidth - (leading.width + trailing.width))
    let blankStack = StringStack(
      [Array(repeating: " ", count: available)]
    )
    let body = Box.Part(type: .blank, stringStack: blankStack)
    return Line(leading: leading, body: body, trailing: trailing)
  }
}
//
//  public struct TextContent: LineContent {
//    public let rawContent: String
//    public let lineLimit: Int
//
//    init(_ text: String, lineLimit: Int = 0) {
//      self.rawContent = text
//      self.lineLimit = lineLimit
//    }
//  }
//}
