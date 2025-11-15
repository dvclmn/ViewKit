//
//  Coordinator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

extension SyntaxHighlightingTextView {
  // MARK: - Coordinator

  @MainActor
  public class Coordinator: NSObject, NSTextViewDelegate {
    @Binding var text: String
    @Binding var cursorPosition: CursorPosition?

    var highlighter: SyntaxHighlighter
    var inputBehaviors: [TextInputBehavior]
    var debounceInterval: TimeInterval
    let fontSize: CGFloat
    //    weak var textView: NSTextView?
    weak var textView: BackgroundRenderingTextView?

    /// Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?

    init(
      text: Binding<String>,
      cursorPosition: Binding<CursorPosition?>,
      highlighter: SyntaxHighlighter,
      inputBehaviors: [TextInputBehavior],
      debounceInterval: TimeInterval,
      fontSize: CGFloat,
    ) {
      self._text = text
      self._cursorPosition = cursorPosition
      self.highlighter = highlighter
      self.inputBehaviors = inputBehaviors
      self.debounceInterval = debounceInterval
      self.fontSize = fontSize
    }

    public func textDidChange(_ notification: Notification) {
      guard let textView = notification.object as? NSTextView else { return }

      /// Update the binding immediately so SwiftUI stays in sync
      text = textView.string
      updateCursorPosition()

      /// Cancel any pending highlight operation
      highlightWorkItem?.cancel()

      /// Schedule a new highlight operation after the debounce interval
      let workItem = DispatchWorkItem { [weak self] in
        self?.applyHighlighting()
      }
      highlightWorkItem = workItem

      /// Execute after debounce interval on the main queue
      DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval, execute: workItem)
    }

    public func textViewDidChangeSelection(_ notification: Notification) {
      updateCursorPosition()
    }

    private func updateCursorPosition() {
      guard let textView = textView else { return }
      let selectedRange = textView.selectedRange()
      
      DispatchQueue.main.async {
        self.cursorPosition = calculateCursorPosition(in: textView.string, range: selectedRange)
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
      for behavior in inputBehaviors
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
      
      let defaultAttributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 12),
        .foregroundColor: NSColor.labelColor
      ]
      attributedString.setAttributes(defaultAttributes, range: NSRange(location: 0, length: attributedString.length))
      
      let highlightedRanges = highlighter.highlight(text: currentText)
      for (range, attributes) in highlightedRanges {
        attributedString.addAttributes(attributes, range: range)
      }
      
      let selectedRange = textView.selectedRange()
      textView.textStorage?.setAttributedString(attributedString)
      textView.setSelectedRange(selectedRange)
      
      // Update block background ranges
      let blockRanges = highlighter.blockRanges(text: currentText)
      textView.updateBlockRanges(blockRanges)
      
      // Refresh line numbers
      textView.enclosingScrollView?.verticalRulerView?.needsDisplay = true
      
//      guard let textView = textView else { return }
//
//      let currentText = textView.string
//      let attributedString = NSMutableAttributedString(string: currentText)
//
//      /// Apply default attributes to the entire text
//      let defaultAttributes: [NSAttributedString.Key: Any] = [
//        .font: NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular),
//        .foregroundColor: NSColor.labelColor,
//      ]
//      attributedString.setAttributes(defaultAttributes, range: NSRange(location: 0, length: attributedString.length))
//
//      /// Get highlighted ranges from the syntax highlighter
//      let highlightedRanges = highlighter.highlight(text: currentText)
//
//      /// Apply each highlighted range's attributes
//      for (range, attributes) in highlightedRanges {
//        attributedString.addAttributes(attributes, range: range)
//      }
//
//      /// Preserve the current cursor position and selection
//      let selectedRange = textView.selectedRange()
//
//      /// Apply the attributed string to the text storage
//      textView.textStorage?.setAttributedString(attributedString)
//
//      /// Restore the cursor position
//      textView.setSelectedRange(selectedRange)
    }
  }
}
