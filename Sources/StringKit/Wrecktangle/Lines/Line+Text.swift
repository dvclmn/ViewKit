//
//  Line.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

extension Box {

  public struct TextLine: Codable, Sendable, Hashable {
    /// Full-length text content, not reflowed for Box width yet
    public let text: String
    public let leading: Box.PartType
    public let trailing: Box.PartType

    public init(
      text: String,
      leading: Box.PartType,
      trailing: Box.PartType
    ) {
      self.text = text
      self.leading = leading
      self.trailing = trailing
    }
  }
}

extension Box.TextLine: Box.RenderableLine {
  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    let lead = leading.buildPart(with: engine.theme, at: position).string
    let trail = trailing.buildPart(with: engine.theme, at: position).string
    let paddingCount = engine.theme.padding.width
    let padding = String(repeating: " ", count: paddingCount)
    
    let textContent = TextReflow(
      text,
      width: engine.widthForText,
      shouldHyphenate: true
    )
    return textContent.reflowed().map { line in
      lead + padding + line + padding + trail
    }.joined("\n")
  }
}


extension Box.TextLine: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      "Text Content: " + text
      leading.description
      trailing.description
    }.plainText
  }
}
