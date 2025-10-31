//
//  LineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.Line {

  public enum LineType: Hashable, Sendable {
    case text(content: String, lineLimit: Int = 0)

    /// Consists
    case structure(StructureType)
    case blank
  }

  public typealias ThreePartLine = (
    leading: Box.PartType,
    repeater: Box.PartType,
    trailing: Box.PartType
  )

}
