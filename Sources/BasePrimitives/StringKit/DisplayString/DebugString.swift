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

/// ```
/// private func missingValue(_ key: String, for consumer: String) -> String {
///   "EnvironmentValue `\(key)` missing, needed by \(consumer)"
/// }
/// ```
public func printMissing(_ value: String, for consumer: String) {
  print("`\(value)` missing, needed by `\(consumer)`")
}

public func printDidNotSatisfy(
  _ value: String,
  expectation: String,
  for consumer: String
) {
  print("`\(value)` did not match expected result `\(expectation)`, in method `\(consumer)`")
}
