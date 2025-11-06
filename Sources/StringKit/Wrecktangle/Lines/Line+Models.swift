//
//  Line+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Structure
extension Box {
  struct StructureLine {
    let leading: Box.PartType
    let repeating: Box.PartType
    let trailing: Box.PartType

    init(
      _ leading: Box.PartType,
      _ repeating: Box.PartType,
      _ trailing: Box.PartType
    ) {
      self.leading = leading
      self.repeating = repeating
      self.trailing = trailing
    }
  }

  // MARK: - Text
  public struct TextLine: Codable, Sendable, Hashable {
    /// Full-length text content, not reflowed for Box width yet
    public let leading: Box.PartType
    public let text: String
    public let trailing: Box.PartType

    public init(
      _ leading: Box.PartType,
      _ text: String,
      _ trailing: Box.PartType
    ) {
      self.leading = leading
      self.text = text
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
