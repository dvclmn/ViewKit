//
//  Part+Corner.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

extension Box {
  public struct Part {
    public var content: GlyphStack
//    public var content: StringStack
    public var type: PartType
    
    public init(content: GlyphStack, type: PartType) {
      self.content = content
      self.type = type
    }
  }
  
}

extension Box.Part {
  public var flexibility: Box.PartType.Flexibility {
    type.flexibility
  }
  public var width: Int { content.width }
  public var height: Int { content.height }
  public var columns: Int { width }
  public var rows: Int { height }

  var stringStack: StringStack {
    
  }
  
  public static func create(
    _ type: Box.PartType,
    with theme: Box.Theme
  ) -> Self {

    let stack = type.glyphStack(for: theme.frameStyle)
    let characterGrid = stack.map { row in
      row.map { theme.glyphSet.character(for: $0) }
    }
    let multilineString = StringStack(characterGrid)
    return Self(content: multilineString, type: type)
  }
}
