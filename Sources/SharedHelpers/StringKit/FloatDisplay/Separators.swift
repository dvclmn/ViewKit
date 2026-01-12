//
//  Separators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/10/2025.
//

import EnumMacros
import Foundation

//extension Separators {
public struct SeparatorVisibility: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let propertyLabel = Self(rawValue: 1 << 0)
  public static let component = Self(rawValue: 1 << 1)
  public static let both: Self = [.propertyLabel, .component]
}

//extension SeparatorVisibility {
//  public var hasSeparator: Bool { !isEmpty }
//}
//}

//public struct Separators {
//
//  /// Seperates the `key` from the `value`
//  /// E.g. the `": "` from `X: 10, Y: -20`
//  ///
//  /// Who handles this separator?
//  /// The type that holds onto both a `PropertyLabel`
//  /// and a `value: any StringConvertible`.
//  /// This is often a single `Component`
//  let propertyLabelSeparator: String
//
//  /// Seperates two (or more) `key-value` pairs
//  /// E.g. the `" x "` from `800 x 600px`
//  /// Or the `", "` from `X: 10, Y: -20`
//  ///
//  /// Who handles this separator?
//  /// Whoever handles joining multiple `Component`s
//  /// This is often a build expression?
//  let componentSeparator: String
//
//  public init(
//    propertyLabel: String,
//    component: String
//  ) {
//    self.propertyLabelSeparator = propertyLabel
//    self.componentSeparator = component
//  }
//}
