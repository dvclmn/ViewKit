//
//  AttributedString.swift
//  TextCore
//
//  Created by Dave Coleman on 31/8/2024.
//

import SwiftUI

extension AttributedString {
  public var toString: String { String(self.characters) }

  public func index(at offset: Int) -> AttributedString.Index? {
    guard offset >= 0 && offset <= characters.count else {
      return nil
    }
    return index(startIndex, offsetByCharacters: offset)
  }
  
  
  ///
  /// ```
  /// var output = attrString
  ///
  /// let numberByNumberPattern: Regex.TripleCapture = /([\d\.]+)(x)([\d\.]+)/
  ///
  /// if let ranges = getRange(for: numberByNumberPattern, in: output) {
  ///   output[ranges.0].setAttributes(style(for: part, subPart: .number))
  ///   output[ranges.1].setAttributes(style(for: part, subPart: .operator))
  ///   output[ranges.2].setAttributes(style(for: part, subPart: .number))
  /// }
  ///
  /// return output
  /// ```

  public mutating func quickHighlight() {
    let highlightContainer: AttributeContainer = .colours(.black, on: .green)
    self.setAttributes(highlightContainer)
  }

  public func lines(
    subsequenceStrategy: SubsequenceStrategy = .doNotOmit
  ) -> [String] {
    return self.toString.lines(subsequenceStrategy: subsequenceStrategy)
  }

  public var lines: [String] {
    self.lines(subsequenceStrategy: .doNotOmit)
  }

  public mutating func append(
    _ string: String,
    addsLineBreak: Bool
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(string)\n" : "\(string)")
  }

  public mutating func append(
    _ character: Character,
    addsLineBreak: Bool
  ) {
    self.characters.append(contentsOf: addsLineBreak ? "\(character)\n" : "\(character)")
  }

  public mutating func addLineBreak() {
    self.characters.append("\n")
  }

}

extension Array where Element == AttributedString {
  public func joined(_ separator: String = "") -> AttributedString {
    guard !isEmpty else { return AttributedString() }

    /// Pre-create separator once to avoid repeated initialisation
    let separatorAttr = AttributedString(separator)

    /// Use reduce(into:) for in-place mutation (no copies)
    return dropFirst().reduce(into: self[0]) { result, element in
      result.append(separatorAttr)
      result.append(element)
    }
  }
}

extension AttributedString {
  public func appending(_ string: String) -> AttributedString {
    var copy = self
    copy.append(string.toAttributed)
    return copy
  }
  //  public static func + (lhs: AttributedString, rhs: String) -> AttributedString {
  //    var result = lhs
  //    result.append(AttributedString(rhs))
  //    return result
  //  }
  //
  //  public static func + (lhs: String, rhs: AttributedString) -> AttributedString {
  //    var result = AttributedString(lhs)
  //    result.append(rhs)
  //    return result
  //  }
}

extension String {
  /// Returns an attributed string
  public func appending(_ attributed: AttributedString) -> AttributedString {
    var attr = self.toAttributed
    attr.append(attributed)
    return attr

  }
}
