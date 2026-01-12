//
//  DebugString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

public func DebugString(
  @DisplayStringBuilder _ content: () -> [DisplayBlock]
) {
  let displayString = DisplayString {
    content()
  }
  print(displayString.text + "\n")
}
