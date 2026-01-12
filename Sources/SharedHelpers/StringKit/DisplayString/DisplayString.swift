//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import SwiftUI


public struct DisplayString {
  
  private let components: [DisplayBlock]
  
  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  private let separator: String
  
  public init(
    _ separator: String = "\n",
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) {
    self.separator = separator
    self.components = content()
  }
}

public func DisplayStringText(
  _ separator: String = "\n",
  @DisplayStringBuilder _ content: () -> [DisplayBlock]
) -> String {
  let blocks = content()
  return blocks.output(separator: separator)
}


extension DisplayString {
  public var text: String { components.output(separator: separator) }
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

