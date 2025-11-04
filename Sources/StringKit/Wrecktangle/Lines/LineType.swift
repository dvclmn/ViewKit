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
    case bottom
  }
}

/// Joins horizontally
public func + (lhs: Box.LineType, rhs: Box.LineType) -> [Box.LineType] {
  [lhs, rhs]
}

//extension Box.LineType {
//  public func output(
//    width: Int,
//    theme: Box.Theme
//  ) -> StringStack {
//    switch self {
//      case .text(let content, _):
//        textLine(
//          content,
//          toWidth: width,
//          using: theme
//        )
//      case .structure(let type):
//        type.line(
//          toWidth: width,
//          using: theme
//        )
//      case .blank: StringStack("")
//    }
//  }

//  public static func joined(
//    width: Int,
//    lines: [Box.LineType],
//    with theme: Box.Theme
//  ) -> StringStack {
//
//    let stacks = lines.map { line in
//      line.output(width: width, theme: theme)
//    }
//    let joined = StringStack.joined(stacks, along: .vertical)
//    return joined
//  }
//
//  public static func joined(
//    width: Int,
//    lines: Box.LineType...,
//    with theme: Box.Theme
//  ) -> StringStack {
//    Self.joined(width: width, lines: lines, with: theme)
//  }

//}

//extension Box.LineType {
//  fileprivate func textLine(
//    _ content: String,
//    toWidth width: Int,
//    using theme: Box.Theme
//  ) -> StringStack {
//
//
//  }
//}
