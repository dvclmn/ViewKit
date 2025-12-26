//
//  NSAttributedString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/7/2025.
//

//#if canImport(AppKit)
import AppKit

extension NSMutableAttributedString {

  @MainActor public func setAttributeSet(
    _ attributeSet: AttributeSet,
    range: NSRange,
    with typingAttributes: NSTextAttributes? = nil
  ) {

    if let typingAttributes {
      setAttributes(attributeSet.attributes, range: range)
      addAttributes(typingAttributes, range: range)
    } else {
      setAttributes(attributeSet.attributes, range: range)
    }
  }

  public var fullRange: NSRange { NSRange(location: 0, length: self.length) }

}

//extension Dictionary where Key == NSAttributedString.Key, Value == Any {
//  public func prettyPrinted(including customAttributeKeys: [NSAttributedString.Key]) -> String {
//    let keysToPrint: [NSAttributedString.Key] =
//      [
//        .foregroundColor,
//        .font,
//        .backgroundColor,
//      ]
//      + customAttributeKeys
//
//    let something = self.compactMap { element -> String? in
//      let key = element.key
//      let val = element.value
//      guard keysToPrint.contains(key) else { return nil }
//      if let color = val as? NSColor {
//        return "\(key): \(color.description)"
//      } else {
//        return "\(key): \(val)"
//      }
//
//    }
//  }
//}

//#endif
