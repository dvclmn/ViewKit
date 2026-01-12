//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI

/// - Parameters:
///   - separator: Text that separates each individual block element within the builder
///   - content: The contents of the DisplayString
/// - Returns: A joined String, delimited by the provided separator.
public func DisplayString(
  _ separator: String = "\n",
  @DisplayStringBuilder _ content: () -> [DisplayBlock]
) -> String {
  let blocks = content()
  return blocks.compactMap(\.toString).joined(separator)
  
}

extension DisplayBlock {
  public static func string(for value: Any?) -> String {
    guard let value else { return "nil" }
    guard let convertible = value as? StringConvertible else { return String(describing: value) }
    return convertible.toString
  }
  
  public static func displayBlock(for value: Any?) -> DisplayBlock {
    let text = string(for: value)
    return DisplayBlock.text(text)
  }
}

extension Array where Element == DisplayBlock {
  public func output(separator: String = "\n") -> String {
    compactMap(\.toString).joined(separator)
  }
}

extension AttributedString {
  public func monospaced(_ font: Font? = nil) -> AttributedString {
    self.transformingAttributes(\.font) { attr in
      attr.value = font?.monospaced() ?? Font.body.monospaced()
    }
  }

}

