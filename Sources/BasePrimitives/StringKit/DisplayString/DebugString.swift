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

// appendInterpolation<T>(_ value: T?, default: @autoclosure () -> some StringProtocol)

//public func printMissing<T>(_ value: T?, for consumer: String) {
//public func printMissing(_ value: Any?, for consumer: String) {

/// Example output:
/// ```
/// `unitSize` missing, needed by `GridLineContext`
/// ```
public func printMissing(_ value: String, for consumer: String) {
  print("`\(value)` missing, needed by `\(consumer)`")
//  print("`\(String(describing: value))` missing, needed by `\(consumer)`")
}

public func printDidNotSatisfy(
  _ value: String,
  expectation: String,
  for consumer: String
) {
  print("`\(value)` did not match expected result `\(expectation)`, in method `\(consumer)`")
}
