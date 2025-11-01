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
    width: Int
  ) -> Box.Line {
    let leading = Box.PartType.vertical(.leading).build(using: theme)
    let trailing = Box.PartType.vertical(.trailing).build(using: theme)
    
    let remaining = width - (leading.width + trailing.width)
    let bodyStack = StringStack([Array(text.prefix(remaining))])
    let body = Box.Part(content: bodyStack, type: .blank)
    
    return Box.Line(leading: leading, body: body, trailing: trailing)
  }

  static func structureLine(
    _ type: Box.PartType,
    theme: Box.Theme,
    width: Int
  ) -> Box.Line {
    let leading = Box.PartType.corner(.topLeading).build(using: theme)
    let body = type.build(using: theme)
    let trailing = Box.PartType.corner(.topTrailing).build(using: theme)
    return Box.Line(leading: leading, body: body, trailing: trailing)
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
