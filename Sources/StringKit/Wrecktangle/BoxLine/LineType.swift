//
//  LineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box.Line {
  public enum LineType: Hashable, Sendable {
    case text(
      content: String,
      lineLimit: Int = 0
    )
    case structure(StructureType)
    case blank
  }
  public enum StructureType: Hashable, Sendable {
    case top
    case divider(String = "-")
    case bottom
  }
}
