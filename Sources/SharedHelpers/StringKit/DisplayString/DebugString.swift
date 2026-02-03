//
//  DebugString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation
import BasePrimitives

public func DebugString(
  timestamped: Bool = false,
  @DisplayStringBuilder _ content: () -> [DisplayBlock]
) {
  print(
    DisplayString {
      content()
      timestamped ? " at \(Date.debug) " : ""
      "\n"
    }.text
  )
}
