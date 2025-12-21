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

extension NSRange {
  public var info: String {
    "NSRange(location: \(location), length: \(length))"
  }

  public static let zero = NSRange(location: 0, length: 0)
  public static let notFound = NSRange(location: NSNotFound, length: 0)

  public var debugDescription: String {
    "NSRange(location: \(location), length: \(length))"
  }

  public var max: Int { NSMaxRange(self) }

  /// Returns an NSRange that will not exceed a limit
  ///
  /// This functions ensures that the resulting range
  /// does not exceed the supplied limit. The result
  /// will have a location <= the limit, and may
  /// have zero length.
  public func clamped(to limit: Int) -> NSRange {
    if location == NSNotFound { return self }

    let start = Swift.min(location, limit)
    let end = Swift.min(max, limit)

    return NSRange(start..<end)
  }
}

/// Possibly helpful notes:
/// Source - https://stackoverflow.com/a
/// Posted by Sulthan, modified by community. See post 'Timeline' for change history
/// Retrieved 2025-12-21, License - CC BY-SA 4.0
///
/// ```
/// let text = "abc"
/// let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
/// let lastChar: Character = text[index2] //now we can index!
///
/// let characterIndex2 = text.index(text.startIndex, offsetBy: 2)
/// let lastChar2 = text[characterIndex2] //will do the same as above
///
/// let range: Range<String.Index> = text.range(of: "b")!
/// let index: Int = text.distance(from: text.startIndex, to: range.lowerBound)
/// ```

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
    ///
    let attributedStringRange: Range<AttributedString.Index> = start..<end

    return attributedStringRange
  }
}

extension Range {
  /// ```
  /// let range = Range(match.output.1.indices)`
  /// ```
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
