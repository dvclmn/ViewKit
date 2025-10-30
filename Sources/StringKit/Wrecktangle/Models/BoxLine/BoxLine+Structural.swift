//
//  BoxLine+Structural.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

extension Box.Builder.Line {

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
