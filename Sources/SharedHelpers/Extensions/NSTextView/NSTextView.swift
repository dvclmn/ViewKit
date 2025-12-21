//
//  NSTextView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

import AppKit

extension NSTextView {

  public func setInsets(_ size: CGSize) {
    self.textContainer?.lineFragmentPadding = size.width
    self.textContainerInset = NSSize(
      width: 0,
      height: size.height
    )
  }

  /// Get the full bounds of the current text.
  private var documentBounds: NSRange {
    NSRange(location: 0, length: textStorage?.length ?? 0)
  }
  
  public var nsString: NSString { string as NSString }

  public var documentLength: Int { nsString.length }

//  public var safeCurrentParagraphRange: NSRange {
//    let paragraphRange: NSRange = nsString.paragraphRange(for: safeSelectedRange)
//    return paragraphRange.clamped(to: documentLength)
//  }
  
  public var safeCurrentParagraphRange: NSRange {
    /// 1. Get the safe selection first
    let safeSelection = safeSelectedRange
    
    /// 2. Expand to paragraph.
    /// `NSString.paragraphRange` always returns a valid range within string
    /// bounds if the input is valid, so no secondary clamping required here.
    return nsString.paragraphRange(for: safeSelection)
  }

  /// Uses `NSIntersectionRange` to strictly enforce bounds.
  public func getSafeRange(for range: NSRange) -> NSRange {
    NSIntersectionRange(range, documentBounds)
  }
  
  public var safeSelectedRange: NSRange {
    getSafeRange(for: selectedRange)
  }
//  public var safeSelectedRange: NSRange {
//    selectedRange.clamped(to: documentLength)
//  }
//
//  public func getSafeRange(for range: NSRange) -> NSRange {
//    range.clamped(to: documentLength)
//  }

  public func string(for range: NSRange) -> String? {
    guard textStorage != nil else { return nil }
    
    /// Reuse the centralised safety check
    let validRange = getSafeRange(for: range)
    
    /// Handle empty ranges (like a caret position) gracefully.
    return nsString.substring(with: validRange)
  }
  
//  public func string(for range: NSRange) -> String? {
//    guard let ts = textStorage else { return nil }
//
//    /// Ensure the range is valid
//    let validRange = NSIntersectionRange(
//      range, NSRange(location: 0, length: ts.length))
//    guard validRange.length > 0 else { return nil }
//
//    /// Use `NSAttributedString`'s `substring(with:) `method
//    return ts.attributedSubstring(from: validRange).string
//  }

  public func boundingRect(
    for range: NSRange,
    lm layoutManager: NSLayoutManager,
    tc textContainer: NSTextContainer,

  ) -> CGRect {
    let glyphRange = layoutManager.glyphRange(
      forCharacterRange: range,
      actualCharacterRange: nil
    )

    /// Get the bounding rect for this glyph range
    /// This tells us where the text physically appears on screen
    let boundingRect = layoutManager.boundingRect(
      forGlyphRange: glyphRange,
      in: textContainer
    )

    return boundingRect
  }

}
