//
//  Line+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

extension Box.Line {

  public static func create(_ type: Box.ContentPart) -> Self {
    switch type {
      case .text(let content): createTextLine(content)
      case .structure(let type): createStructureLine(type)
    }
  }

  private static func createTextLine(_ content: String) -> Self {
    return Box.Line(
      content,
      leading: .vertical(.leading),
      trailing: .vertical(.trailing)
    )
  }

  private static func createStructureLine(
    _ type: Box.StructureType
  ) -> Self {
    return Box.Line(
      type.parts.repeater,
      leading: type.parts.leading,
      trailing: type.parts.trailing
    )
    //    let parts:
    //      (
    //        leading: Box.PartType,
    //        repeater: Box.PartType,
    //        trailing: Box.PartType
    //      ) =
    //        switch type {
    //          case .top:
    //
    //            (
    //              .corner(.topLeading),
    //              .horizontal(.top),
    //              .corner(.topTrailing),
    //            )
    //
    //          case .divider:
    //
    //            (
    //              .join(.leading),
    //              .horizontal(.interior),
    //              .join(.trailing),
    //            )
    //
    //          case .bottom:
    //
    //            (
    //              .corner(.bottomLeading),
    //              .horizontal(.bottom),
    //              .corner(.bottomTrailing),
    //            )
    //
    //          case .blank:
    //
    //            (
    //              .vertical(.leading),
    //              .blank,
    //              .vertical(.trailing),
    //            )
    //        }
    //
    //    return Box.Line(
    //      parts.repeater,
    //      leading: parts.leading,
    //      trailing: parts.trailing
    //    )
  }
}
