//
//  DisplayBlock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/10/2025.
//

import AppKit
//import EnumMacros
import Foundation

/// Note: have removed `display`, as this was mirroring `FloatRenderable`
///
/// Akin to a document AST (text / labelled / indented / divider etc). Helps determine
/// what is semantic? And keeps mess/formatting out of ``DisplayStringBuilder``
public enum DisplayBlock: Sendable {
  case text(DisplayFragment)
  case labeled(Labeled)
//  case labeled(key: String, separator: String, value: DisplayFragment?)
  case indented(Indented)
  case divider(String)
//  case components([Labeled])
}

extension DisplayBlock {

  /// Where should I decide how to render an optional?
  /// Currently it seems fragmented. Maybe move it here, at least
  public func render(using format: FloatDisplayFormat) -> String {
    let string: String? = switch self {
      case .text(let fragment):
        fragment.render(using: format)

      case .labeled(let label):
//      case .labeled(let key, let sep, let value):
        label.toString(using: format)
//        return Labeled.toString(key: key, value: value, separator: sep, using: format)

      case .divider(let text):
        text

      case .indented(let indented):
        indented.render(using: format)
        
//      case .components(let items):
        
    }
    
    return string ?? "nil"
  }

  //  public var label: Labeled? {
  //    guard case let .labeled(key, sep, value) = self else { return nil }
  //    return Labeled(key, value: value, separator: sep)
  //  }
}

//@CaseDetection(includesNames: true)
//public enum DisplayBlock: Sendable {
//  case text(any StringRenderable)
//  //  case text(String)
//  case indented(Indented)
//  case float(any FloatRenderable)
//  case floatGroup(any PropertiesLabeled)
//  //case divider(Divider)
//  /// Note: This previously drove ``Divider``
////  case display(any DisplayStringRenderable)
//  case labeled(Labeled)
//}

//extension DisplayBlock {
//  init(from value: Any?) {
//    self =
//      switch value {
//        case let result as any PropertiesLabeled:
//          .floatGroup(result)
//
//        case let result as any FloatRenderable:
//          .float(result)
//
//        case let result as StringRenderable:
//          .text(result.toString)
//
//        case let result as Labeled:
//            .labeled(result)
////        case let result as DisplayStringRenderable:
////          .display(result)
//
//        case let result as NSEvent.Phase:
//          .text(result.description)
//
//        case let result as CustomStringConvertible:
//          .text(result.description)
//
//        case nil:
//          .text("nil")
//
//        default:
//          .text(String(describing: value))
//      }
//  }
//}

//extension DisplayBlock {
//  public func renderBlock(using format: FloatDisplayFormat) -> String {
//    switch self {
//      case .text(let text): text.toString
//      case .float(let value): value.render(using: format)
//      case .floatGroup(let value): value.renderProperties(using: format)
//      //      case .floatGroup(let value): value.render(using: format)
//      case .indented(let indented): indented.render(using: format)
//      case .labeled(let labeled): labeled.....
////      case .display(let value): value.displayString(format.)
//    //      case .labeled(let value): value.render(using: format)
//    }
//  }
//}

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
