//
//  Line+StructureType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box.StructureType {
  func parts() -> [Box.PartType] {
    switch self {
      case .top:
        [
          .corner(.topLeading),
          .horizontal(.top),
          .corner(.topTrailing),
        ]

      case .divider:
        [
          .join(.leading),
          .horizontal(.interior),
          .join(.trailing),
        ]

      case .bottom:
        [
          .corner(.bottomLeading),
          .horizontal(.bottom),
          .corner(.bottomTrailing),
        ]

      case .blank:
        [
          .vertical(.leading),
          .blank,
          .vertical(.trailing),
        ]
    }
  }
}
