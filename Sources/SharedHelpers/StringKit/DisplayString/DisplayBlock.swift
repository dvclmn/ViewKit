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
  //  case text(String)
  //  case indented(Indented)
  case float(any FloatRenderable)
  case floatGroup(any PropertiesLabeled)
  case display(any DisplayRenderable)

}

extension DisplayBlock: DisplayRenderable {
  public func render(using format: DisplayFormat) -> String {
    switch self {
      case .text(let text): text
      case .float(let value): value.render(using: format)
      case .floatGroup(let value): value.render(using: format)
      case .indented(let indented): indented.render(using: format)
      case .display(let value): value.render(using: format)
    }
  }

  //  public func render(using format: DisplayFormat) -> String {
  //    switch self {
  //      case .text(let text):
  //        text
  //
  //      case .indented(let indented):
  //        indented.render(using: format)
  //    }
  //  }
}

extension DisplayBlock {
  var indentationDepth: Int {
    switch self {
//      case .text, .float, .floatGroup, .display: 0
      case .indented(let indented):
        1 + (indented.content.map(\.indentationDepth).max() ?? 0)
      default: 0
    }
  }

  //  public var toString: String? {
  //    switch self {
  //      case .text(let text): text
  //      case .indented(let indented):
  //    }
  //  }

}
