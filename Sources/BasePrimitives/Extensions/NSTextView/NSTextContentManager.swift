//
//  NSTextContentManager.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/12/2025.
//

#if canImport(AppKit)
import AppKit

/// From forum post:
/// https://developer.apple.com/forums/thread/693905?answerId=784645022#784645022
extension NSTextContentManager {
  public func range(for textRange: NSTextRange) -> NSRange? {
    let location = offset(from: documentRange.location, to: textRange.location)
    let length = offset(from: textRange.location, to: textRange.endLocation)
    if location == NSNotFound || length == NSNotFound { return nil }
    return NSRange(location: location, length: length)
  }

  public func textRange(for range: NSRange) -> NSTextRange? {
    guard
      let textRangeLocation = location(documentRange.location, offsetBy: range.location),
      let endLocation = location(textRangeLocation, offsetBy: range.length)
    else { return nil }
    return NSTextRange(location: textRangeLocation, end: endLocation)
  }
  
//  public func textRange(for range: Range<String.Index>) -> NSTextRange? {
//    guard
//      let textRangeLocation = location(documentRange.location, offsetBy: range.location),
//      let endLocation = location(textRangeLocation, offsetBy: range.length)
//    else { return nil }
//    return NSTextRange(location: textRangeLocation, end: endLocation)
//  }
}
#endif
