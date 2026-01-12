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
  private let format: DisplayFormat
  
  public init(
    _ components: [DisplayBlock],
    separator: String,
    format: DisplayFormat
  ) {
    self.components = components
    self.separator = separator
    self.format = format
  }

}

extension DisplayString {
  
  public init(
    _ separator: String = "\n",
    format: DisplayFormat = .default,
    @DisplayStringBuilder _ content: () -> [DisplayBlock]
  ) {
    self.separator = separator
    self.format = format
    self.components = content()
  }
}

//public func DisplayStringText(
//  _ separator: String = "\n",
//  @DisplayStringBuilder _ content: () -> [DisplayBlock]
//) -> String {
//  let blocks = content()
//  return blocks.output(separator: separator)
//}

extension DisplayString {
  public var text: String {
    components.output(
      separator: separator,
      format: format
    )
  }
  
  public func decimalPlaces(_ places: Int) -> DisplayString {
    var newFormat = format
    newFormat.decimalPlaces = places
    
    return DisplayString(
      components,
      separator: separator,
      format: newFormat,
    )
  }
}

extension Array where Element == DisplayBlock {
  public func output(
    separator: String = "\n",
    format: DisplayFormat = .default
  ) -> String {
    map { $0.render(using: format) }
      .joined(separator)
  }
}

extension AttributedString {
  public func monospaced(_ font: Font? = nil) -> AttributedString {
    self.transformingAttributes(\.font) { attr in
      attr.value = font?.monospaced() ?? Font.body.monospaced()
    }
  }

}
