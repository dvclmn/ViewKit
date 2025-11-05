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

extension Box.TextLine: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      "Text Content: " + text
      leading.description
      trailing.description
    }.plainText
  }
}
