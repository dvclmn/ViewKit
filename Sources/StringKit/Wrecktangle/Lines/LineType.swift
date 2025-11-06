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
}
extension Box.LineType {

  func buildString(
    using engine: Box.Engine,
    at position: Box.PositionContext
  ) -> String {
    switch self {
      case .structure(let type):
        let string = type.parts.buildString(using: engine, at: position)
//        print("Structure/\(type.rawValue), String: \(string)")
        return string
        
      case .text(let line):
        return line.buildString(using: engine, at: position)
    }
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
