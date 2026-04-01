//
//  NSTextView.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

#if canImport(AppKit)
import AppKit

extension NSTextView {

  public func setInsets(_ size: CGSize) {
    self.textContainer?.lineFragmentPadding = size.width
    self.textContainerInset = NSSize(
      width: 0,
      height: size.height,
    )
  }

  /// Get the full bounds of the current text.
  public var documentNSRange: NSRange {
    NSRange(location: 0, length: textStorage?.length ?? 0)
  }

  public var documentRange: NSTextRange? { self.textLayoutManager?.documentRange }

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
    NSIntersectionRange(range, documentNSRange)
  }

  public var safeSelectedRange: NSRange {
    getSafeRange(for: selectedRange)
  }

  public func string(for range: NSRange) -> String? {
    guard textStorage != nil else { return nil }

    /// Reuse the centralised safety check
    let validRange = getSafeRange(for: range)

    /// Handle empty ranges (like a caret position) gracefully.
    return nsString.substring(with: validRange)
  }

  public func boundingRect(
    for range: NSRange,
    lm layoutManager: NSLayoutManager,
    tc textContainer: NSTextContainer,

  ) -> CGRect {
    let glyphRange = layoutManager.glyphRange(
      forCharacterRange: range,
      actualCharacterRange: nil,
    )

    /// Get the bounding rect for this glyph range
    /// This tells us where the text physically appears on screen
    let boundingRect = layoutManager.boundingRect(
      forGlyphRange: glyphRange,
      in: textContainer,
    )

    return boundingRect
  }

  /// Converts an NSRange to an NSTextRange for the current content manager
  public func textRange(for range: NSRange) -> NSTextRange? {
    guard let tcm = self.textLayoutManager?.textContentManager else { return nil }
    return tcm.textRange(for: range)
    //    guard let textLayoutManager = self.textLayoutManager,
    //      let contentManager = textLayoutManager.textContentManager,
    //      let documentRange = contentManager.documentRange
    //    else { return nil }
    //
    //    // Calculate start and end locations based on offsets
    //    guard let start = contentManager.location(
    //        documentRange.location, offsetBy: range.location),
    //      let end = contentManager.location(start, offsetBy: range.length)
    //    else { return nil }
    //
    //    return NSTextRange(location: start, end: end)
  }

  /// TextKit 2 equivalent of boundingRect(forGlyphRange:...)
  public func boundingRect(for textRange: NSTextRange) -> CGRect {
    guard let textLayoutManager = self.textLayoutManager else { return .zero }

    var unionRect: CGRect = .null

    /// .standard includes the visible glyphs.
    /// Use `.selection` or `.highlight` to encompass the full line height/advance.
    textLayoutManager.enumerateTextSegments(
      in: textRange,
      type: .standard,
      options: [],
    ) {
      segmentRange, rect, baseline, textContainer in

      /// The rect provided is in the TextContainer's coordinate system.
      /// We must translate it to the Text View's coordinate system.
      var viewRect = rect
      viewRect.origin.x += self.textContainerOrigin.x
      viewRect.origin.y += self.textContainerOrigin.y

      unionRect = unionRect.union(viewRect)

      return true  // Continue enumeration
    }

    return unionRect.isNull ? .zero : unionRect
  }
}
#endif
