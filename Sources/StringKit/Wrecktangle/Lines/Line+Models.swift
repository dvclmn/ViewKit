//
//  Line+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

extension Box {
  public enum ContentPart {
    case text(String)
    case structure(StructureType)
//    case customPart(PartType)
//    case structure(PartType)
  }
}

extension Box.ContentPart: CustomStringConvertible {
  public var description: String {
    switch self {
      case .text(let text): text
      case .structure(let type): "\(type)"
//      case .customPart(let part): part.description
    }
  }
}

// MARK: - Structure
//extension Box {
//  struct StructureLine {
//    let leading: Box.PartType
//    let repeating: Box.PartType
//    let trailing: Box.PartType
//
//    init(
//      _ leading: Box.PartType,
//      _ repeating: Box.PartType,
//      _ trailing: Box.PartType
//    ) {
//      self.leading = leading
//      self.repeating = repeating
//      self.trailing = trailing
//    }
//  }
//
//  // MARK: - Text
//  public struct TextLine: Codable, Sendable, Hashable {
//    /// Full-length text content, not reflowed for Box width yet
//    public let leading: Box.PartType
//    public let text: String
//    public let trailing: Box.PartType
//
//    public init(
//      _ leading: Box.PartType,
//      _ text: String,
//      _ trailing: Box.PartType
//    ) {
//      self.leading = leading
//      self.text = text
//      self.trailing = trailing
//    }
//  }
//}

extension Box.Line: CustomStringConvertible {
//extension Box.TextLine: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      body.description
      leading.description
      trailing.description
    }.plainText
  }
}
