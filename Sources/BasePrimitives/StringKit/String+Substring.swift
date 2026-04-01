//
//  String+Substring.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/12/2025.
//

#if canImport(AppKit)
import AppKit

extension Substring {
  /// Converts the Substring's range into an NSRange relative to its containing (base) String.
  ///
  /// This is safe to use with APIs like NSRegularExpression, NSAttributedString,
  /// and NSTextView that expect ranges based on UTF-16 code units.
  public var nsRangeUsingSubstringBase: NSRange {
    return NSRange(self.startIndex..<self.endIndex, in: self.base)
  }

  public func nsRange(in text: String) -> NSRange {
    return NSRange(self.startIndex..<self.endIndex, in: text)
  }

}

extension Array where Element == Substring {
  public var characterCount: Int {
    reduce(0) { accumulatingResult, nextValue in
      accumulatingResult + nextValue.count
    }
  }
}
#endif
