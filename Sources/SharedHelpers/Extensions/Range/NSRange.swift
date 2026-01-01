//
//  NSRange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension NSRange {
  public func debugPreview(
    in text: String,
    contextLength: Int = 30,
    highlight: (String) -> String = { "░\($0)░" }
  ) -> String {
    guard let stringRange = toStringRange(in: text) else {
      return "Unable to convert NSRange to Range<String.Index>"
    }
    return stringRange.debugPreview(
      in: text,
      contextLength: contextLength,
      highlight: highlight
    )
  }
  
  public func toStringRange(in text: String) -> Range<String.Index>? {
    Range(self, in: text)
  }
  
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
