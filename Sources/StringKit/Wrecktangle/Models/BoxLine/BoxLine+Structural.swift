//
//  BoxLine+Structural.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box.Line {

  public struct StructuralContent: LineContent {
    public let rawContent: String

    init(
      adjustedWidth: Int,
      repeatingPattern: Box.Part
    ) {
      let contentString = repeatingPattern.content.repeatHorizontally(toWidth: adjustedWidth)
      self.rawContent = contentString.string
    }
  }
}

extension Box.Line.StructuralContent {
  
  private func buildStructureLine(
    builder: Box.Builder,
//    for type: Box.Line.StructureType,
//    hasLineBreak: Bool
  ) -> String {
    
    let parts = type.parts
    
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
}
