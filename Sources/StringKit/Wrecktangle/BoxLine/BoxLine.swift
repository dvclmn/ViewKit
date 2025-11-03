//
//  Line.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

/// ``Box``
/// ``Box/Line``
///
/// I am opting to keep this flatter nesting (e.g. not nesting
/// `PartType` further, within `Part`. Otherwise
/// nesting will become too deep and unweildy.
/// ``Box/Part``
/// ``Box/PartType``
///
///
/// ``Box/Theme``
/// ``Box/Config``

extension Box {

  public struct TextLine: Codable, Sendable {
    public let leading: Box.PartType
    public let text: String
    public let trailing: Box.PartType

    public init(
      leading: Box.PartType,
      text: String,
      trailing: Box.PartType
    ) {
      self.leading = leading
      self.text = text
      self.trailing = trailing
    }
  }

  public struct StructureLine: Codable, Sendable {
    public let leading: Box.PartType
    public let body: Box.PartType
    public let trailing: Box.PartType

    public init(
      leading: Box.PartType,
      body: Box.PartType,
      trailing: Box.PartType
    ) {
      // Basic invariant: if body is text (single row), caps must be 1 high.
      //            precondition(
      //              !(body.isText && (leading.height > 1 || trailing.height > 1)),
      //              """
      //              Text lines must have single-character caps.
      //              Leading: \(leading.height), Trailing: \(trailing.height)
      //              """
      //            )
      self.leading = leading
      self.body = body
      self.trailing = trailing
    }
  }
}
extension Box.StructureLine {

  func build(theme: Box.Theme) -> StringStack {
    StringStack.joined(
      leading.buildStack(using: theme),
      body.buildStack(using: theme),
      trailing.buildStack(using: theme),
      along: .horizontal
    )
  }

  static func structure(
    for type: Box.StructureType,
    with theme: Box.Theme
  ) -> StringStack {
    switch type {
      case .top:
        Box.StructureLine(
          leading: .join(.cross),
//          leading: .corner(.topLeading),
          body: .horizontal(.top),
          trailing: .corner(.topTrailing)
        ).build(theme: theme)

      case .divider:
        Box.StructureLine(
          leading: .vertical(.leading),
          body: .horizontal(.interior),
          trailing: .vertical(.trailing),
        ).build(theme: theme)

      case .bottom:
        Box.StructureLine(
          leading: .corner(.bottomLeading),
          body: .horizontal(.bottom),
          trailing: .corner(.bottomTrailing)
        ).build(theme: theme)
    }

  }
}
