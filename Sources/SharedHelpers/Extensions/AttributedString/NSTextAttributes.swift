//
//  TextAttributes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/12/2025.
//

import AppKit

public typealias NSTextAttributes = [NSAttributedString.Key: Any]

extension NSTextAttributes {
  public var names: String {
    let names: String = self.reduce(into: "") { partialResult, entry in
      let key = entry.key
      let val = entry.value
      partialResult += "Key: \(key.prettyDescription), Value: \(val)\n"
    }
    return names + "\n"
  }

}

public struct TextDecoration: Sendable, Hashable {
  let colour: NSColor
  let style: NSUnderlineStyle

  public enum Kind {
    case underline
    case strikethrough
  }
}

extension TextDecoration {
  
  public static let `default`: TextDecoration = .init(colour: .red, style: .single)
  //  public func setTextDecoration(
  //    _ kind: TextDecoration.Kind,
  ////    decoration: TextDecoration
  //    attrs: inout NSTextAttributes
  //  ) {
  //    setTextDecoration(kind, colour: decoration.colour, style: decoration.style)
  //  }

  public func setTextDecoration(
    _ kind: TextDecoration.Kind,
    attrs: inout NSTextAttributes
  ) {
    //    let decoration = TextDecoration(colour: colour, style: style)
    let attr = getAttributes(for: kind)
    attrs.merge(attr, uniquingKeysWith: { _, new in new })
  }

  private func getAttributes(for kind: Kind) -> NSTextAttributes {
    switch kind {
      case .strikethrough:
        [
          .strikethroughColor: colour,
          .strikethroughStyle: style.rawValue,
        ]
      case .underline:
        [
          .underlineColor: colour,
          .underlineStyle: style.rawValue,
        ]
    }
  }
}

extension NSAttributedString.Key {
  public var prettyDescription: String {
    switch self {
      case .font: return "font"
      case .foregroundColor: return "foregroundColor"
      case .backgroundColor: return "backgroundColor"
      case .cursor: return "cursor"
      case .glyphInfo: return "glyphInfo"
      case .imageURL: return "imageURL"
      case .attachment: return "attachment"
      case .inlinePresentationIntent: return "inlinePresentationIntent"
      case .languageIdentifier: return "languageIdentifier"
      case .link: return "link"
      case .markdownSourcePosition: return "markdownSourcePosition"
      case .paragraphStyle: return "paragraphStyle"
      case .presentationIntentAttributeName: return "presentationIntentAttributeName"
      case .strikethroughColor: return "strikethroughColor"
      case .strikethroughStyle: return "strikethroughStyle"
      case .textEffect: return "textEffect"
      case .toolTip: return "toolTip"
      default: return "\(self)"

    }
  }
}
