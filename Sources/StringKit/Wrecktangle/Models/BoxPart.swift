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
}
