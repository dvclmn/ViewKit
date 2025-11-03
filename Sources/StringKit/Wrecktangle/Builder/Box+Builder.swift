//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {
  /// The Builder (aka 'Box Engine') should handle box drawing
  /// based on simple instructions (see ``ViewBox`` and ``HeaderBoxBox``)
  public struct Builder {
    let width: Int

    /// Allows dynamic/flexible height, if not defined
    let height: Int?

    let theme: Box.Theme

    public init(
      width: Int,
      height: Int?,
      theme: Box.Theme
    ) {
      self.width = width
      self.height = height
      self.theme = theme
    }
  }
}

extension Box.Builder {

  public func structureLine(
    type: Box.Line.StructureType
  ) -> Box.Line {
    switch type {
      case .top:
        Box.Line(
          leading: .corner(.topLeading),
          body: .horizontal(.top),
          trailing: .corner(.topTrailing)
        )

      case .divider:
        Box.Line(
          leading: .vertical(.leading),
          body: .horizontal(.interior),
          trailing: .vertical(.trailing),
        )

      case .bottom:
        Box.Line(
          leading: .corner(.bottomLeading),
          body: .horizontal(.bottom),
          trailing: .corner(.bottomTrailing)
        )
    }
  }

  public func textLine(
    content: String
  ) -> Box.Line {

    return Box.Line(
      leading: .vertical(.leading),
      body: .text(content),
      trailing: .vertical(.trailing)
    )
  }

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = theme.frameStyle.reservedDimensions.width
    return max(0, width - capCount)
  }

  public var heightForText: Int? {
    guard let height else { return nil }
    let capCount = theme.frameStyle.reservedDimensions.height
    return max(0, height - capCount)
  }
}

//extension Box.Builder {
//
//  func buildLine(
//    _ lineType: Box.Line.LineType
//  ) -> String {
//    switch lineType {
//      case .text(let content, let lineLimit):
//        return buildTextLine(content: content, lineLimit: lineLimit)
//
//      case .structure(let structureType):
//        return buildStructureLine(for: structureType, hasLineBreak: false)
//
//      case .blank:
//        let lineResult = Box.Line(
//          text: String(repeating: " ", count: widthForText),
//          lineLimit: heightForText ?? 0,
//          remainingWidth: widthForText,
//          theme: config.theme
//        )
//        let lineString = lineResult.render()
//        return lineString
//    }
//  }  // END create line
//
//  private func buildTextLine(
//    content: String,
//    lineLimit: Int
//  ) -> String {
//
//    /// This uses `BoxLine`s text-based initialiser
//    let lineResult = Box.Line(
//      text: content,
//      lineLimit: lineLimit,
//      remainingWidth: widthForText,
//      theme: config.theme
//    )
//    let lineString = lineResult.render()
//    return lineString
//  }
//
//  private func buildStructureLine(
//    for type: Box.Line.StructureType,
//    hasLineBreak: Bool
//  ) -> String {
//
//    let parts = type.parts
//
//    let leading = Box.Part.create(parts.leading, with: config.theme)
//    let repeating = Box.Part.create(parts.repeater, with: config.theme)
//    let trailing = Box.Part.create(parts.trailing, with: config.theme)
//
//    /// This uses `BoxLine`s structure-based initialiser
//    let lineResult = Box.Line(
//      remainingWidth: widthForText,
//      repeater: repeating,
//      leadingCap: leading,
//      trailingCap: trailing,
//      theme: config.theme
//    )
//
//    let lineString = lineResult.render()
//
//    let result = lineString + (hasLineBreak ? "\n" : "")
//    return result
//
//  }
//
//  //  private func buildShadow(for lineType: BoxLine.LineType, hasLineBreak: Bool) -> String {
//  //
//  //    if lineType.hasShadow(lightSource: shadow.lightSource) {
//  //
//  //      let shadowWidth: Int = boxWidth
//  //      let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
//  //
//  ////      let shadowWithCaps = shadowCap().leading + shadowRepeated + shadowCap().trailing
//  //
//  //      let result = shadowRepeated + (hasLineBreak ? "\n" : "")
//  ////      let result = shadowWithCaps + (hasLineBreak ? "\n" : "")
//  //
//  //      return result
//  //
//  //    } else {
//  //      return ""
//  //    }
//  //
//  //  }
//}
