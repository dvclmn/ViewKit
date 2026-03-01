//
//  TextAttributes.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/12/2025.
//

#if canImport(AppKit)
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

  public mutating func setTextDecoration(
    for kind: TextDecoration.Kind,
    _ decoration: TextDecoration?,
  ) {
    guard let decoration else { return }
    let decorationAttrs = decoration.getAttributes(for: kind)
    merge(decorationAttrs, uniquingKeysWith: { _, new in new })

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

  fileprivate func getAttributes(for kind: Kind) -> NSTextAttributes {
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

#endif