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

extension Box.LineType {
  public func output(theme: Box.Theme) -> StringStack {
    switch self {
      case .text(let content, _):
        let leading = Box.PartType.vertical(.leading).buildStack(using: theme)
        let trailing = Box.PartType.vertical(.trailing).buildStack(using: theme)
        let contentStack = StringStack(content)

        return StringStack.joined(
          leading,
          trailing,
          contentStack,
          along: .horizontal
        )

      case .structure(let type):
        return Box.StructureLine.structure(
          for: type,
          with: theme
        )
      case .blank:
        return StringStack("")
    }
  }
}
