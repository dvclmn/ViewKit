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
public enum DisplayBlock {
//public enum DisplayBlock: StyledStringConvertible {
  case text(String)
//  case styledText(StyledString)
  case indented(Indented)

  var indentationDepth: Int {
    switch self {
      case .text: return 0
//      case .styledText: return 0
      case .indented(let indented):
        return 1 + (indented.content.map(\.indentationDepth).max() ?? 0)
    }
  }
}

extension DisplayBlock {
  public var toString: String? {
    switch self {
      case .text(let text): text
//      case .styledText: nil
      case .indented(let indented): createIndented(for: indented)
    }
  }
  
//  public var toStyledString: StyledString {
//    switch self {
//      case .text(let text): text
////      case .styledText(let styledString): styledString
//      case .indented(let indented): createIndented(for: indented)
//    }
//  }

}
