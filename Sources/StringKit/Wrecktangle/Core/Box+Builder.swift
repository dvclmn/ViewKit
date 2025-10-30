//
//  BoxLine+Construct.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box {
  public struct Builder {
    let width: Int
    let height: Int?
    let theme: Box.Theme

    public init(
      width: Int,
      height: Int? = nil,
      theme: Box.Theme = .init()
    ) {
      self.width = width
      self.height = height
      self.theme = theme
    }
  }
}

extension Box.Builder {

  /// The remaning width for text, after removing space
  /// reserved for structural elements
  public var widthForText: Int {
    let capCount = theme.frameStyle.maximumGridSize.width.value
    return max(0, width - capCount)
  }
}

extension Box.Builder {

  func buildLine(
    _ lineType: Box.Line.LineType
  ) -> String {
    switch lineType {
      case .text(let content, let lineLimit):
        return buildTextLine(content: content, lineLimit: lineLimit)
      case .structure(let structureType):
        return buildStructureLine(for: structureType, hasLineBreak: false)
    }
  }  // END create line

  private func buildTextLine(
    content: String,
    lineLimit: Int
  ) -> String {

    //    switch lineType {

    //      case .text(let content, let lineLimit):

    /// This uses `BoxLine`s text-based initialiser
    let lineResult = Box.Line(
      text: content,
      lineLimit: lineLimit,
      remainingWidth: widthForText,
      theme: theme
    )

    let lineString = lineResult.render()

    return lineString

    //      case .top, .divider, .bottom, .blank:
    //        return buildStructureLine(for: lineType, hasLineBreak: false)
    //    }

  }

  private func buildStructureLine(
    for type: Box.Line.StructureType,
    //    for preset: Line.LineType,
    hasLineBreak: Bool
  ) -> String {

    let parts = type.parts
    //    guard let parts = preset.parts else {
    //      return "nil"
    //    }

    let leading = Box.Part.create(parts.leading, with: theme)
    let repeating = Box.Part.create(parts.repeater, with: theme)
    let trailing = Box.Part.create(parts.trailing, with: theme)

    /// This uses `BoxLine`s structure-based initialiser
    let lineResult = Box.Line(
      remainingWidth: widthForText,
      repeater: repeating,
      leadingCap: leading,
      trailingCap: trailing,
      theme: theme
    )

    let lineString = lineResult.render()

    let result = lineString + (hasLineBreak ? "\n" : "")
    return result

  }

  //  private func buildShadow(for lineType: BoxLine.LineType, hasLineBreak: Bool) -> String {
  //
  //    if lineType.hasShadow(lightSource: shadow.lightSource) {
  //
  //      let shadowWidth: Int = boxWidth
  //      let shadowRepeated = String(repeating: shadowCharacter, count: shadowWidth)
  //
  ////      let shadowWithCaps = shadowCap().leading + shadowRepeated + shadowCap().trailing
  //
  //      let result = shadowRepeated + (hasLineBreak ? "\n" : "")
  ////      let result = shadowWithCaps + (hasLineBreak ? "\n" : "")
  //
  //      return result
  //
  //    } else {
  //      return ""
  //    }
  //
  //  }
}
