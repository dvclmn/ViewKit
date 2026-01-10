//
//  Pickable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/9/2025.
//

import Foundation

public protocol Pickable: LabeledItem, Shortcuttable
where Self: CaseIterable, Self.AllCases: RandomAccessCollection {

  /// A label that describes the purpose of the whole enum.
  /// E.g. "View Mode", or "Inspector Tab"
  static var pickerLabel: QuickLabel { get }
  func isSelected(current: Self) -> Bool
}

extension Pickable {
  public func isSelected(current: Self) -> Bool {
    return self == current
  }
}

extension Pickable {
  public static var pickerLabel: QuickLabel {
    let typeName = String(describing: Self.self)
    let words = typeName.camelCaseToWords
    return QuickLabel(words)
  }
}

extension String {
  var camelCaseToWords: String {
    // Handle both upper camel case (PatternType) and lower camel case (patternType)
    let pattern = "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])"
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let range = NSRange(location: 0, length: self.count)

    let spaced =
      regex?
      .stringByReplacingMatches(in: self, options: [], range: range, withTemplate: " ")
      .capitalized ?? self

    return spaced
  }
}
