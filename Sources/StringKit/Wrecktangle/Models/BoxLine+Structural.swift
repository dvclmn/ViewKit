//
//  BoxLine+Structural.swift
//  BoxCore
//
//  Created by Dave Coleman on 13/9/2024.
//

public extension BoxCore.BoxLine {

  struct StructuralContent: LineContent {
    public let rawContent: String
    
    init(
      adjustedWidth: Int,
      repeatingPattern: BoxCore.BoxPart
    ) {

      let contentString = repeatingPattern.content.repeatHorizontally(toWidth: adjustedWidth)
      self.rawContent = contentString.string
    }

  }
}
