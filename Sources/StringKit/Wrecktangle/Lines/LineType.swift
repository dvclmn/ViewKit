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
    case text(String)
//    case text(TextLine)
    case structure(StructureType)
  }
}
extension Box.LineType {

  /// This is plural because it returns an *array* of Strings; however, this actually
  /// only represents a *single* ``Box/LineType``. Box Lines can, however,
  /// be made up of multiple rows of text, e.g. when a Frame Part is more than
  /// one character high.
//  func buildBoxLine(
//    using engine: Box.Engine,
//    startingAt rowIndex: inout Int
////    at position: Box.PositionContext
//  ) -> StringStack {
//    switch self {
//      case .structure(let type):
//        let string = type.parts.buildBoxLine(using: engine, at: position)
//        return string
//
//      case .text(let line):
//        return line.buildLines(using: engine, at: position)
//    }
//  }
//  
//  func buildBoxLines(
//    using engine: Box.Engine,
//    startingAt rowIndex: inout Int
//  ) -> [StringStack] {
//    
//    switch self {
//      case .structure(let type):
//        let pos = Box.PositionContext(i: rowIndex, rowCount: 0)
//        rowIndex += 1
//        return [type.parts.buildBoxLine(using: engine, at: pos)]
//        
//      case .text(let line):
//        let lines = line.buildTextLines(using: engine, startingAt: &rowIndex)
//        return lines
//    }
//  }
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
