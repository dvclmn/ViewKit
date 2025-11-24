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

  //  public var documentNSRange: NSRange {
  //    guard let tcm = self.textLayoutManager?.textContentManager else {
  //      return .notFound
  //    }
  //    return NSRange(tcm.documentRange, provider: tcm)
  //  }

  public var nsString: NSString { string as NSString }

  public var documentLength: Int { nsString.length }

  public var safeCurrentParagraphRange: NSRange {
    let paragraphRange: NSRange = nsString.paragraphRange(for: safeSelectedRange)
    return paragraphRange.clamped(to: documentLength)
  }

  public var safeSelectedRange: NSRange {

    let result: NSRange = selectedRange.clamped(to: documentLength)

    //    print("Calculated safeSelectedRange: \(result)")
    return result
  }

  public func getSafeRange(for range: NSRange) -> NSRange {
    return range.clamped(to: documentLength)
  }

  public func string(for range: NSRange) -> String? {
    guard let textStorage = textStorage else { return nil }

    /// Ensure the range is valid
    let validRange = NSIntersectionRange(range, NSRange(location: 0, length: textStorage.length))
    guard validRange.length > 0 else { return nil }

    /// Use `NSAttributedString`'s `substring(with:) `method
    return textStorage.attributedSubstring(from: validRange).string
  }
  
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
