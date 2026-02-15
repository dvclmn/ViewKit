//
//  DigitPadding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/6/2025.
//

import Foundation

extension String {

  /// Usage
  /// `5.leftPadded(to: 4, with: "0") // "0005"`
  public func leftPadded(
    to length: Int,
    with character: Character = " "
  ) -> String {
    let currentWidth = count
    if currentWidth >= length { return self }
    let padding = String(repeating: character, count: length - currentWidth)
    return padding + self
  }
}

extension Int {
  public func leftPadded(
    to length: Int,
    with character: Character = " "
  ) -> String {
    String(self).leftPadded(to: length, with: character)
  }
}
