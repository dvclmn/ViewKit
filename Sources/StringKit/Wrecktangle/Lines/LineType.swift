//
//  LineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {
  public enum LineType: Hashable, Sendable {
    
    /// Important: This `content` represents the bulk/raw
    /// text content, *before* any width-aware reflowing.
    /// This operation is performed later.
    case text(TextLine)
    case structure(StructureType)
  }

  public enum StructureType: String, Hashable, Sendable {
    case top
    case divider
    case bottom
    case blank
  }
}

/// Joins horizontally
public func + (lhs: Box.LineType, rhs: Box.LineType) -> [Box.LineType] {
  [lhs, rhs]
}

extension Box.LineType: CustomStringConvertible {
  public var description: String {
    switch self {
      case .text(let textLine):
        "TextLine/\(textLine)"
        
      case .structure(let structureType):
        "StructureLine/\(structureType.rawValue)"
    }
  }
}
