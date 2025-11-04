//
//  Line.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

extension Box {

  public struct TextLine: Codable, Sendable, Hashable {
    public let leading: Box.PartType
    public let text: String
    public let trailing: Box.PartType

    public init(
      leading: Box.PartType,
      text: String,
      trailing: Box.PartType
    ) {
      self.leading = leading
      self.text = text
      self.trailing = trailing
    }
  }
}

