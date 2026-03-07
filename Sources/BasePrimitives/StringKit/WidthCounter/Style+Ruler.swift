//
//  Style+Ruler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

extension WidthCounter {

  public func generateCompactCounter() -> String {
    let startingFrom: Int = 0

    var compactLine = startingFrom.description
    var i = 5
    while i <= width {
      let spaces = String(repeating: " ", count: i <= 9 ? 4 : 3)
      if i % 10 == 5 {
        compactLine += spaces + "· "
      } else {
        /// Align two-digit numbers with the first digit over the marker
        if i >= 10 {
          compactLine += String(repeating: " ", count: 3) + String(i)
        } else {
          compactLine += spaces + String(i)
        }
      }
      i += 5
    }

    /// Handle the final number
    if width % 5 != 0 {
      let lastNumberString = String(width)
      let spacesNeeded = width - compactLine.count - lastNumberString.count
      if spacesNeeded > 0 {
        compactLine += String(repeating: " ", count: spacesNeeded) + lastNumberString
      } else {
        /// If we've overshot, trim the line and add the last number
        compactLine = String(compactLine.prefix(width - lastNumberString.count)) + lastNumberString
      }
    }

    return compactLine
  }

}
