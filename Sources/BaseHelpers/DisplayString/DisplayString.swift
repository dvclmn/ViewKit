//
//  Model+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/10/2025.
//

import Foundation

public struct DisplayString {
//public struct DisplayString<Value: StringConvertible> {

  private let content: [any StringConvertible]
//  let content: [any StringConvertible]
//  let content: [Value]
  
  /// This is the *top-level* seperator, that appears between
  /// each element in the builder (defined on a new line in
  /// the source code). Defaults to and is frequently set to
  /// a new line character `"\n"`
  let separator: String

  public init<T: StringConvertible>(
    separator: String = ", ",
    @SequenceBuilder<T> _ content: () -> [T]
  ) {
    self.separator = separator
    self.content = content().map { $0 as any StringConvertible }
  }

  
//  public init(
//    separator: String = ", ",
//    @DisplayStringBuilder _ content: () -> [String]
////    @DisplayStringBuilder _ content: () -> [Value]
//  ) {
//    self.separator = separator
//    self.content = content().map(\.stringValue)
//  }
}

extension DisplayString {

  /// Trying this out as a default output value
  public var output: String {
//  public var output: some StringConvertible {
    let stringValue = content.map { convertible in
      convertible.stringValue
    }.joined(separator: separator.stringValue)

    return stringValue
  }
}
//extension DisplayString {

  /// This allows customisation at the conformance site,
  /// e.g. for `CGPoint`:
  /// ```
  /// func displayString(
  ///   _ places: DecimalPlaces = .fractionLength(2),
  ///   grouping: Grouping = .automatic,
  ///   labelStyle: DisplayLabelStyle = .standard
  /// ) -> String {
  ///   DisplayString(separator: ", ") {
  ///     Component("X", value: self.x)
  ///     Component("Y", value: self.y)
  ///   }
  ///   .formatted(
  ///     places,
  ///     grouping: grouping,
  ///     labelStyle: labelStyle
  ///   )
  /// }
  /// ```
  //  func formatted(
  //    _ places: DecimalPlaces,
  //    grouping: Grouping,
  //    labelStyle: PropertyLabel.Style
  //  ) -> String {
  //
  //    if let floatValues = content as? [any FloatDisplay] {
  //
  //      let labelValuePairs = floatValues.map { component in
  //        let labelSep = component
  //        let label = labelStyle.labelString(for: component)
  //        let value = component.value.displayString(places, grouping: grouping)
  //        guard let label else {
  //          return value
  //        }
  //        return label + labelSep + value
  //      }
  //      let result = labelValuePairs.joined(separator: separator)
  //      return result
  //
  //    } else {
  //      return output
  //    }
  //  }
//}
