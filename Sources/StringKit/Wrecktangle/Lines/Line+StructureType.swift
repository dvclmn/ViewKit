//
//  Line+StructureType.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

extension Box.StructureType {
  func line(
    toWidth width: Int,
    using theme: Box.Theme
  ) -> StringStack {
    let stacks = parts().map { part in
      part.buildStack(toWidth: width, using: theme)
    }
    return StringStack.joined(stacks, along: .horizontal)
  }

  private func parts() -> [Box.PartType] {
    switch self {
      case .top:
        [
          .corner(.topLeading),
          .horizontal(.top),
          .corner(.topTrailing),
        ]

      case .divider:
        [
          .vertical(.leading),
          .horizontal(.interior),
          .vertical(.trailing),
        ]

      case .bottom:
        [
          .corner(.bottomLeading),
          .horizontal(.bottom),
          .corner(.bottomTrailing),
        ]
    }
  }
}
