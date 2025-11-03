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
    let width: Int

    /// Allows dynamic/flexible height, if not defined
    let height: Int?

    let paddingCharacter: Character
    let theme: Box.Theme

    public init(
      width: Int,
      height: Int?,
      theme: Box.Theme,
      paddingCharacter: Character = " "
    ) {
      self.width = width
      self.height = height
      self.paddingCharacter = paddingCharacter
      self.theme = theme
    }
  }
}

extension Box.Engine {

  public func textLines(
    _ content: String,
    lineLimit: Int = 0
  ) -> [Box.LineType] {
    let text = TextReflow(
      content,
      width: widthForText,
      paddingCharacter: paddingCharacter,
      shouldHyphenate: true
    )
    let reflowed = text.reflowed(maxLines: lineLimit, paddingH: theme.padding.width)
    //    let reflowed: [String] = [
    //      "Test one",
    //      "And two",
    //      "Then three",
    //    ]

    let lines = reflowed.map { line in
      textLine(content: line)
    }
    return lines
  }

  func structureLine(
    type: Box.StructureType
  ) -> Box.LineType {
    return Box.LineType.structure(type)
//    switch type {
//      case .top:
//        Box.Line(
//          leading: .corner(.topLeading),
//          body: .horizontal(.top),
//          trailing: .corner(.topTrailing)
//        )
//
//      case .divider:
//        Box.Line(
//          leading: .vertical(.leading),
//          body: .horizontal(.interior),
//          trailing: .vertical(.trailing),
//        )
//
//      case .bottom:
//        Box.Line(
//          leading: .corner(.bottomLeading),
//          body: .horizontal(.bottom),
//          trailing: .corner(.bottomTrailing)
//        )
//    }
  }

  public func textLine(
    content: String
  ) -> Box.LineType {
    
    return Box.LineType.text(content: content, lineLimit: 0)
//    print("Single Text Line: \(content)")
//    return Box.LineType(
//      leading: .vertical(.leading),
//      body: .text(content),
//      trailing: .vertical(.trailing)
//    )
  }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = theme.frameStyle.reservedDimensions.width
    let finalWidth = max(0, width - capCount)
//    print("Width for text: \(finalWidth)")
    return finalWidth
  }

  public var heightForText: Int? {
    guard let height else { return nil }
    let capCount = theme.frameStyle.reservedDimensions.height
    return max(0, height - capCount)
  }
}
