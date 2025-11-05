//
//  Line+StructureType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box {
  public enum StructureType: String, Hashable, Sendable {
    case top
    case divider
    case bottom
    case blank
  }

  struct StructureLine {
    let leading: Box.PartType
    let repeating: Box.PartType
    let trailing: Box.PartType

    init(
      _ leading: Box.PartType,
      _ repeating: Box.PartType,
      _ trailing: Box.PartType
    ) {
      self.leading = leading
      self.repeating = repeating
      self.trailing = trailing
    }
  }
}

extension Box.StructureLine {
  func buildParts(using engine: Box.Engine) -> String {
    let leadStr = leading.buildPart(using: engine)
    let trailStr = trailing.buildPart(using: engine)
    let repeatStr = repeating.buildPart(using: engine, repeatCount: engine.widthForPartRepetition)
    
    let string = StringStack.joined(
      leadStr, repeatStr, trailStr,
      along: .horizontal
    ).string
    
    return string
  }
}

extension Box.StructureType {
  var parts: Box.StructureLine {
    switch self {
      case .top:
        Box.StructureLine(
          .corner(.topLeading),
          .horizontal(.top),
          .corner(.topTrailing),

        )

      case .divider:
        Box.StructureLine(
          .join(.leading),
          .horizontal(.interior),
          .join(.trailing),
        )

      case .bottom:
        Box.StructureLine(
          .corner(.bottomLeading),
          .horizontal(.bottom),
          .corner(.bottomTrailing),
        )

      case .blank:
        Box.StructureLine(
          .vertical(.leading),
          .blank,
          .vertical(.trailing),
        )
    }
  }
}
