//
//  LineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {
  public enum LineType: Hashable, Sendable {
//    case text
    case text(
      content: String,
      lineLimit: Int = 0
    )
    case structure(StructureType)
    case blank
  }
  public enum StructureType: Hashable, Sendable {
    case top
    case divider
//    case divider(String = "-")
    case bottom
  }
}
