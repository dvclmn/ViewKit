//
//  Part+Corner.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation
import SharedHelpers

extension Box {

  public struct Part {
    public let type: PartType
    public let stringStack: StringStack

    public var width: Int { stringStack.width }
    public var height: Int { stringStack.height }

    public var flexibility: PartType.Flexibility { type.flexibility }
  }
}

extension Box.Part {
  func render(toWidth target: Int? = nil) -> String {
    guard let target,
      flexibility == .repeatable(axis: .horizontal)
    else { return stringStack.string }

    return stringStack.repeatHorizontally(toWidth: target).string
  }
}

extension StringStack {
  public init(
    from glyphStack: Box.GlyphStack,
    theme: Box.Theme
  ) {
    let grid = glyphStack.map { row in
      row.map { glyphType in
        theme.glyphSet.character(for: glyphType)
      }
    }
    self.init(grid)
  }
}

extension Box.PartType {
  /// Build this specific Part
  func buildFrame(using theme: Box.Theme) -> Box.Part {
//    let glyphStack = theme.frameStyle.glyphStack(for: theme.frameStyle)
    let frameStack = theme.frameStyle.glyphStack(for: self)
    let stringStack = frameStack.map { row in
      row.map { theme.glyphSet.character(for: $0) }
    }
    return Box.Part(type: self, stringStack: StringStack(charGrid))
  }
}

//  public struct Part {
//    public let type: PartType
//    public let glyphs: [[Character]]
//    public var size: GridDimensions {
//      GridDimensions(width: glyphs.first?.count ?? 0, height: glyphs.count)
//    }
//  }

//  public struct Part {
//    public var content: GlyphStack
////    public var content: StringStack
//    public var type: PartType
//
//    public init(content: GlyphStack, type: PartType) {
//      self.content = content
//      self.type = type
//    }
//  }

//}

//extension Box.Part {
//  public var flexibility: Box.PartType.Flexibility {
//    type.flexibility
//  }
//  public var width: Int { content.width }
//  public var height: Int { content.height }
//  public var columns: Int { width }
//  public var rows: Int { height }

//  var stringStack: StringStack {
//
//  }

//  public static func create(
//    _ type: Box.PartType,
//    with theme: Box.Theme
//  ) -> Self {
//
//    let stack = type.glyphStack(for: theme.frameStyle)
//    let characterGrid = stack.map { row in
//      row.map { theme.glyphSet.character(for: $0) }
//    }
//    let multilineString = StringStack(characterGrid)
//    return Self(content: multilineString, type: type)
//  }

//  var stringStack: StringStack {
//    switch type.flexibility {
//      case .repeatable(let axis):
//        // already a uniform grid; fine
//        return content.stringStack
//      case .fixed:
//        return content.stringStack
//    }
//  }
//
//  var isText: Bool {
//    type == .blank // or however you distinguish text placeholders
//  }
//}

//extension Box.Part {
//
//  func render(toWidth target: Int? = nil) -> String {
//    if let target, flexibility == .repeatable(axis: .horizontal) {
//      return content.repeatHorizontally(toWidth: target).string
//    } else {
//      return content.string
//    }
//  }
//
//  func build(using theme: Box.Theme) -> Box.Part {
//    let glyphStack = glyphStack(for: theme.frameStyle)
//    let grid = glyphStack.map { row in
//      row.map { theme.glyphSet.character(for: $0) }
//    }
//    return Box.Part(type: self, glyphs: grid)
//  }
//}
