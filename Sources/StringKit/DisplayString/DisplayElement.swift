//
//  DisplayBlock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import EnumMacros
import Foundation
import SharedHelpers

@CaseDetection(includesNames: true)
public enum DisplayBlock: StyledStringConvertible {
  case text(StyledString)
  case indented(Indented)
  //  case indented(title: String?, indent: String, content: [DisplayBlock])

  var indentationDepth: Int {
    switch self {
      case .text: return 0
      case .indented(let indented):
        return 1 + (indented.content.map(\.indentationDepth).max() ?? 0)
    }
  }
}

extension DisplayBlock {

  public var toStyledString: StyledString {
    switch self {
      case .text(let styledString):
        return styledString

      case .indented(let indented):
        return createIndented(for: indented)
    }
  }

}
