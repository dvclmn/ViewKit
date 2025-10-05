//
//  SequenceBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/10/2025.
//

import Foundation
//public typealias DisplayStringBuilder = SequenceBuilder<StringConvertible>

/// Good to remember:
/// The `{Example}Builder` (the type decorated directly with
/// `@resultBuilder`), is not the right place to have various
/// parameters passed in, like a function would.
///
/// The place for this is on the *function or type* that *uses*
/// the builder. Such as the below `DisplayString`.
///
/// It accepts a parameter, `separator`, making this type
/// the place that can be configured. Not the builder itself.
/// ```
/// public struct DisplayString {
///   let content: [any StringConvertible]
///   let separator: String
///
///   public init(
///     separator: String = .defaultComponentSeparator,
///     @DisplayStringBuilder _ content: () -> [any StringConvertible]
///   ) {
///     self.separator = separator
///     self.content = content()
///   }
/// }
/// ```

@resultBuilder
public struct DisplayStringBuilder {
  public static func buildBlock(_ components: DisplayUnit...) -> [DisplayUnit] {
    components
  }
  
  public static func buildOptional(_ component: [DisplayUnit]?) -> [DisplayUnit] {
    component ?? []
  }
  
  public static func buildEither(first component: [DisplayUnit]) -> [DisplayUnit] {
    component
  }
  
  public static func buildEither(second component: [DisplayUnit]) -> [DisplayUnit] {
    component
  }
  
  public static func buildArray(_ components: [[DisplayUnit]]) -> [DisplayUnit] {
    components.flatMap { $0 }
  }
  
  // MARK: - buildExpression overloads
  
  public static func buildExpression(_ string: String) -> DisplayUnit {
    DisplayUnit(string)
  }
  
  public static func buildExpression(_ attributed: AttributedString) -> DisplayUnit {
    DisplayUnit(attributed)
  }
  
  public static func buildExpression(_ value: some StringConvertible) -> DisplayUnit {
    DisplayUnit(value.stringValue)
  }
}

//@resultBuilder
//public struct DisplayStringBuilder {
//  public static func buildBlock(_ components: StringConvertible...) -> [String] {
//    components.map(\.stringValue)
//  }
//
//  public static func buildOptional(_ component: StringConvertible?) -> [String] {
//    component.map { [$0.stringValue] } ?? []
//  }
//
//  public static func buildEither(
//    first component: StringConvertible
//  ) -> [String] {
//    [component.stringValue]
//  }
//  
//  public static func buildEither(
//    second component: StringConvertible
//  ) -> [String] {
//    [component.stringValue]
//  }
//
//  public static func buildArray(
//    _ components: [[StringConvertible]]
//  ) -> [String] {
//    components.flatMap { $0.map { $0.stringValue } }
//  }
//}
