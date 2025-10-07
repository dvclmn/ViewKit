//
//  PrintPadded.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/9/2025.
//

import Foundation

public func printPadded(
  _ items: Any...,
  separator: String = " ",
  withTimestamp: Bool = true
) {
  let adjustedMessage = "\(items)\n\n"
  guard withTimestamp else {
    print(adjustedMessage, separator: separator)
    return
  }

  let timestamp: String = Date.now.formatted(
    .dateTime
      .hour(.twoDigits(amPM: .abbreviated))
      .minute(.twoDigits)
      .second(.twoDigits)
      .secondFraction(.milliseconds(3))
  )
  print("(\(timestamp)) " + adjustedMessage, separator: separator)
}
