//
//  DisplayBlock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import AppKit
import BasePrimitives
import EnumMacros
import Foundation

/// Note: have removed `display`, as this was mirroring `FloatRenderable`
///
/// I think I can see `DisplayBlock` as being a way to keep various type casting
/// etc out of the `DisplayStringBuilder`
@CaseDetection(includesNames: true)
public enum DisplayBlock: Sendable {
  case text(any StringRenderable)
  //  case text(String)
  case indented(Indented)
  case float(any FloatRenderable)
  case floatGroup(any PropertiesLabeled)
  //case divider(Divider)
  /// Note: This previously drove ``Divider``
  //  case display(any DisplayRenderable)
    case labeled(Labeled)
}

extension DisplayBlock {
  init(from value: Any?) {
    self =
      switch value {
        case let result as any PropertiesLabeled:
          .floatGroup(result)

        case let result as any FloatRenderable:
          .float(result)

        case let result as StringRenderable:
          .text(result.toString)

        case let result as NSEvent.Phase:
          .text(result.description)

        case let result as CustomStringConvertible:
          .text(result.description)

        case nil:
          .text("nil")

        default:
          .text(String(describing: value))
      }
  }
}

extension DisplayBlock {
  public func renderBlock(

    using format: FloatDisplayFormat
  ) -> String {
    switch self {
      case .text(let text): text.toString
      case .float(let value): value.render(using: format)
      case .floatGroup(let value): value.renderProperties(using: format)
      //      case .floatGroup(let value): value.render(using: format)
      case .indented(let indented): indented.render(using: format)
    //      case .display(let value): value.render(using: format)
    //      case .labeled(let value): value.render(using: format)
    }
  }
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
}
