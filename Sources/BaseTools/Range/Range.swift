//
//  Range.swift
//  Collection
//
//  Created by Dave Coleman on 22/12/2024.
//

// Credit to Matt Massicotte and team from ChimeHQ
// for some of these methods below
// https://github.com/ChimeHQ/Rearrange

import Foundation

extension CountableClosedRange where Bound == Int {

  public func attributedRange(for attrString: AttributedString) -> Range<AttributedString.Index>? {
    let start = attrString.index(at: self.lowerBound)
    let end = attrString.index(at: self.upperBound + 1)

    guard let start, let end else { return nil }
    return start..<end
  }
}

extension Range where Bound == String.Index {

  public func toNSRange(in string: String) -> NSRange? {
    string.nsRange(from: self)
  }

  public func getAttributedRange(
    in attrString: AttributedString
  ) -> Range<AttributedString.Index>? {

    /// Convert String.Index range to AttributedString.Index range
    ///
    let startIndex = AttributedString.Index(self.lowerBound, within: attrString)
    let endIndex = AttributedString.Index(self.upperBound, within: attrString)

    /// Check if both indices are valid
    ///
    guard let start = startIndex, let end = endIndex else {
      print("Invalid range")
      return nil
    }

    /// Create the AttributedString range
    let attributedStringRange: Range<AttributedString.Index> = start..<end

    return attributedStringRange
  }
}

extension Range {

  /// ```
  /// let range = Range(match.output.1.indices)`
  /// ```
  /// See: https://forums.swift.org/t/getting-the-range-of-a-regex-capture/83012/4
  public init<Collection: Swift.Collection>(_ indices: DefaultIndices<Collection>)
  where Collection.Index == Bound {
    self = indices.startIndex..<indices.endIndex
  }
}

extension Array where Element == Range<String.Index> {
  public func toNSRanges(in string: String) -> [NSRange] {
    self.compactMap { stringRange in
      guard let range = stringRange.toNSRange(in: string) else {
        print("Could not convert to NSRange")
        return nil
      }
      return range

    }
  }
}

extension Collection {
  /// Meant to help with getting Regex *capture group* ranges
  /// `match.1.output.indexRange`
  /// See: https://forums.swift.org/t/getting-the-range-of-a-regex-capture/83012/2
  public var indexRange: Range<Index> {
    startIndex..<endIndex
  }
}

extension Range where Bound: BinaryFloatingPoint {
  public var length: Self.Bound {
    upperBound - lowerBound
  }
}
