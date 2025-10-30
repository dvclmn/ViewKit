//
//  Part+Corner.swift
//  BoxCore
//
//  Created by Dave Coleman on 11/9/2024.
//

import Foundation

public struct BoxPart {
  public var content: MultilineString
  public var type: PartType

  public init(content: MultilineString, type: PartType) {
    self.content = content
    self.type = type
  }
}

extension BoxPart {
  public var width: Int { content.width }
  public var height: Int { content.height }
  public var columns: Int { width }
  public var rows: Int { height }

  public static func create(
    _ type: BoxPart.PartType,
    with theme: Box.Theme
  ) -> BoxPart {

    let glyphGrid = type.preset(with: theme.frameStyle)
    let characterGrid = glyphGrid.map { row in
      row.map { theme.glyphSet.character(for: $0) }
    }

    let multilineString = MultilineString(characterGrid)
    let finalResult: MultilineString
    finalResult = multilineString
    return BoxPart(content: finalResult, type: type)
  }
}
