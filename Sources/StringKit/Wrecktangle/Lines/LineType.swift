//
//  LineType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import EnumMacros

public typealias LinePart = Box.PartRole

extension Box {

  /// Important: This partly exists because we need to somehow
  /// have an intermediate step between PartType and StringStack.
  /// Because Builder Components can't carry engine / row index context
  @AssociatedValues
  enum LineType: Hashable, Sendable {
    case text(String)
    case repeater(LinePart)
  }
}

/// Joins horizontally
func + (lhs: Box.LineType, rhs: Box.LineType) -> [Box.LineType] {
  [lhs, rhs]
}

extension Box.LineType: CustomStringConvertible {
  public var description: String {
    switch self {
      case .text(let textLine):
        "TextLine/\(textLine)"

      case .repeater(let part):
        "StructureLine/\(part)"
    }
  }
}
