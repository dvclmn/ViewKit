//
//  Line+StructureType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box.StructureType {
//  func line(
//    toWidth width: Int,
//    using theme: Box.Theme
//  ) -> StringStack {
//    let stacks = parts().map { part in
//      part.buildStack(toWidth: width, using: theme)
//    }
//    return StringStack.joined(stacks, along: .horizontal)
//  }
//
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
//          .vertical(.leading),
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
