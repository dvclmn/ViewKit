//
//  DigitStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

extension WidthCounter {
  public func generateDigitCounter() -> (tens: String, ones: String) {
    
    let startingNumber: Int = 1
    let totalWidth = width + 1  // To make up for starting from 1
    
    // MARK: - The tens digit
    
    var tensLine = ""
    
    /// Work through each number in the provided width, starting at the
    /// `startingNumber`, up to (but not including) `totalWidth`.
    ///
    for integer in startingNumber..<totalWidth {
      
      /// Now to get the ten's place value, for each `integer`.
      ///
      /// First, we divide by ten. This removes the ones digit and shifts everything
      /// else one place to the right.
      let dividedByTen: Int = integer / 10
      
      ///
      /// Then we use `%` (modulo) to get only the rightmost digit of the result.
      ///
      /// Here's an example, using `243`:
      /// - `243 / 10 = 24` (integer division)
      /// - `24 % 10 = 4`
      ///
      /// This gives us the tens digit (`4`) of `243`.
      ///
      let remainder: Int = dividedByTen % 10
      
      /// Finally we add each result as a String to the `tensLine`
      ///
      tensLine += String(remainder)
      
    }
    
    // MARK: - The ones digit
    
    /// Second line: counting up by one
    var onesLine = ""
    for integer in startingNumber..<totalWidth {
      onesLine += String(integer % 10)
    }
    
    guard tensLine.count == width,
          onesLine.count == width
    else { fatalError("Incorrect width calculation somewhere.") }
    
    return (tensLine, onesLine)
    
  }  // END full counter
}
