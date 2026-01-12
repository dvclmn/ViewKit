//
//  DisplayBlock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import BasePrimitives
import EnumMacros
import Foundation

@CaseDetection(includesNames: true)
public enum DisplayBlock {
  case text(String)
  case indented(Indented)
}

extension DisplayBlock {
  var indentationDepth: Int {
    switch self {
      case .text: 0
      case .indented(let indented):
        1 + (indented.content.map(\.indentationDepth).max() ?? 0)
    }
  }

  public var toString: String? {
    switch self {
      case .text(let text): text
      case .indented(let indented): createIndented(for: indented)
    }
  }
}


