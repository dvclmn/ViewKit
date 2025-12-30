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
