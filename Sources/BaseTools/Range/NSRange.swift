//
//  NSRange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension NSRange {


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
