//
//  Coordinator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

extension SourceEditorView {
  // MARK: - Coordinator

  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate {
    let parent: SourceEditorView
    weak var textView: BackgroundRenderingTextView?

    public init(_ view: SourceEditorView) {
      self.parent = view
    }

    /// Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?

    public func textDidChange(_ notification: Notification) {
      guard let textView = notification.object as? NSTextView else { return }

      /// Update the binding immediately so SwiftUI stays in sync
      parent.text = textView.string
      updateCursorPosition()

      /// Cancel any pending highlight operation
      highlightWorkItem?.cancel()

      /// Schedule a new highlight operation after the debounce interval
      let workItem = DispatchWorkItem { [weak self] in
        self?.applyHighlighting()
      }
      highlightWorkItem = workItem

      /// Execute after debounce interval on the main queue
      DispatchQueue.main.asyncAfter(deadline: .now() + parent.debounceInterval, execute: workItem)
    }

    public func textViewDidChangeSelection(_ notification: Notification) {
      updateCursorPosition()
    }

    private func updateCursorPosition() {
      guard let textView = textView else { return }
      let selectedRange = textView.selectedRange()

      DispatchQueue.main.async {
        self.parent.cursorPosition = calculateCursorPosition(in: textView.string, range: selectedRange)
        // Update typing attributes so new text matches existing style
        self.syncTypingAttributes()
      }
    }
    
    private func syncTypingAttributes() {
      guard let textView else { return }
      
      let loc = textView.selectedRange().location
      guard loc <= textView.string.count, loc > 0 else { return }
      
      let pos = max(loc - 1, 0)
      if pos < textView.textStorage?.length ?? 0,
         let attrs = textView.textStorage?.attributes(at: pos, effectiveRange: nil)
      {
        textView.typingAttributes = attrs
      }
    }

    /// Intercept keypresses to implement custom typing behaviors
    public func textView(
      _ textView: NSTextView, shouldChangeTextIn affectedCharRange: NSRange, replacementString: String?
    ) -> Bool {
      guard let replacementString = replacementString else {
        return true
      }

      /// Give each behavior a chance to handle the input
      for behavior in parent.inputBehaviors
      where behavior.handleKeyPress(
        character: replacementString,
        textView: textView,
        selectedRange: affectedCharRange
      ) {
        /// Behavior handled the input, prevent default processing
        return false
      }

      /// No behavior handled it, allow default processing
      return true
    }

    func applyHighlighting() {
      guard let textView else { return }

      let currentText = textView.string
      let attributedString = NSMutableAttributedString(string: currentText)

      /// Apply default attributes to the entire text
      let defaultAttributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: parent.fontSize),
        .foregroundColor: NSColor.labelColor,
      ]
      attributedString.setAttributes(defaultAttributes, range: NSRange(location: 0, length: attributedString.length))

      /// Get highlighted ranges from the syntax highlighter
      let highlightedRanges = parent.highlighter.highlight(text: currentText)

      /// Apply each highlighted range's attributes
      for (range, attributes) in highlightedRanges {
        attributedString.addAttributes(attributes, range: range)
      }

      /// Preserve the current cursor position and selection
      let selectedRange = textView.selectedRange()

      /// Apply the attributed string to the text storage
      textView.textStorage?.setAttributedString(attributedString)

      /// Restore the cursor position
      textView.setSelectedRange(selectedRange)
      
      syncTypingAttributes()

      /// Update block background ranges
      let blockRanges = parent.highlighter.blockRanges(text: currentText)
      textView.updateBlockRanges(blockRanges)

      /// Refresh line numbers
      textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true

    }
  }
}
