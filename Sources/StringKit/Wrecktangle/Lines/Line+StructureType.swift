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
