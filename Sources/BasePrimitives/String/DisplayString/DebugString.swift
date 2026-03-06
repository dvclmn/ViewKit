//
//  DebugString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public func DebugString(
  _ title: String? = nil,
  indented: Bool = false,
  timestamped: Bool = false,
  @DisplayStringBuilder _ content: () -> [DisplayBlock]
) {
  print(
    DisplayString {
      if indented {
        Indented(title, content: content)
      } else {
        content()
      }
      timestamped ? "\(Date.debug) " : ""
      "\n"
    }.text
  )
}
