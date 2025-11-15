//
//  SourceEditor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import AppKit
import SwiftUI

// MARK: - Syntax Highlighting Protocol

/// Protocol defining how text should be analyzed and highlighted
protocol SyntaxHighlighter {
  func highlight(text: String) -> [NSRange: [NSAttributedString.Key: Any]]
}

// MARK: - Basic Syntax Highlighter Implementation

/// A simple highlighter supporting inline code, keywords, strings, and numbers
class BasicSyntaxHighlighter: SyntaxHighlighter {

  // Define colors for different syntax elements
  private let codeColor = NSColor.systemPurple
  private let keywordColor = NSColor.systemPink
  private let stringColor = NSColor.systemGreen
  private let numberColor = NSColor.systemBlue
  private let codeFont = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)

  func highlight(text: String) -> [NSRange: [NSAttributedString.Key: Any]] {
    var attributes: [NSRange: [NSAttributedString.Key: Any]] = [:]
    let nsString = text as NSString

    // Highlight inline code (text between backticks)
    highlightInlineCode(in: nsString, attributes: &attributes)

    // Highlight keywords (let, var, func, class, etc.)
    highlightKeywords(in: nsString, attributes: &attributes)

    // Highlight strings (text between quotes)
    highlightStrings(in: nsString, attributes: &attributes)

    // Highlight numbers
    highlightNumbers(in: nsString, attributes: &attributes)

    return attributes
  }

  private func highlightInlineCode(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match text between backticks: `code`
    let pattern = "`[^`]+`"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches {
      attributes[match.range] = [
        .foregroundColor: codeColor,
        .font: codeFont,
      ]
    }
  }

  private func highlightKeywords(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Common Swift keywords
    let keywords = ["let", "var", "func", "class", "struct", "enum", "if", "else", "for", "while", "return", "import"]

    for keyword in keywords {
      // Use word boundaries to match whole words only
      let pattern = "\\b\(keyword)\\b"
      guard let regex = try? NSRegularExpression(pattern: pattern) else { continue }

      let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
      for match in matches {
        // Only apply if not already styled (e.g., inside backticks)
        if attributes[match.range] == nil {
          attributes[match.range] = [
            .foregroundColor: keywordColor,
            .font: NSFont.systemFont(ofSize: 12, weight: .semibold),
          ]
        }
      }
    }
  }

  private func highlightStrings(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match strings in double quotes
    let pattern = "\"[^\"]*\""
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: stringColor
      ]
    }
  }

  private func highlightNumbers(in text: NSString, attributes: inout [NSRange: [NSAttributedString.Key: Any]]) {
    // Match numbers (integers and decimals)
    let pattern = "\\b\\d+(\\.\\d+)?\\b"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return }

    let matches = regex.matches(in: text as String, range: NSRange(location: 0, length: text.length))
    for match in matches where attributes[match.range] == nil {
      attributes[match.range] = [
        .foregroundColor: numberColor
      ]
    }
  }
}

// MARK: - NSViewRepresentable Wrapper

@MainActor
struct SyntaxHighlightingTextView: NSViewRepresentable {
  @Binding var text: String
  var highlighter: SyntaxHighlighter
  var debounceInterval: TimeInterval = 0.3  // Wait 300ms after typing stops

  func makeNSView(context: Context) -> NSScrollView {
    // Create the scroll view container
    let scrollView = NSScrollView()
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder

    // Create and configure the text view
    let textView = NSTextView()
    textView.delegate = context.coordinator
    textView.isEditable = true
    textView.isSelectable = true
    textView.font = NSFont.systemFont(ofSize: 12)
    textView.textColor = NSColor.labelColor
    textView.backgroundColor = NSColor.textBackgroundColor
    textView.isAutomaticQuoteSubstitutionEnabled = false
    textView.isAutomaticDashSubstitutionEnabled = false
    textView.isAutomaticSpellingCorrectionEnabled = false

    // Configure for continuous wrapping
    textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    textView.isVerticallyResizable = true
    textView.isHorizontallyResizable = false
    textView.textContainer?.widthTracksTextView = true
    textView.textContainer?.containerSize = NSSize(
      width: scrollView.contentSize.width, height: CGFloat.greatestFiniteMagnitude)

    scrollView.documentView = textView

    // Store the text view in the coordinator for later access
    context.coordinator.textView = textView

    return scrollView
  }

  func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? NSTextView else { return }

    // Only update if the text has changed externally (not from typing)
    if textView.string != text {
      // Preserve cursor position
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)

      // Apply highlighting immediately for external changes
      context.coordinator.applyHighlighting()
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text, highlighter: highlighter, debounceInterval: debounceInterval)
  }

  // MARK: - Coordinator

  @MainActor
  class Coordinator: NSObject, NSTextViewDelegate {
    @Binding var text: String
    var highlighter: SyntaxHighlighter
    var debounceInterval: TimeInterval
    weak var textView: NSTextView?

    // Debouncing mechanism
    private var highlightWorkItem: DispatchWorkItem?

    init(text: Binding<String>, highlighter: SyntaxHighlighter, debounceInterval: TimeInterval) {
      self._text = text
      self.highlighter = highlighter
      self.debounceInterval = debounceInterval
    }

    func textDidChange(_ notification: Notification) {
      guard let textView = notification.object as? NSTextView else { return }

      // Update the binding immediately so SwiftUI stays in sync
      text = textView.string

      // Cancel any pending highlight operation
      highlightWorkItem?.cancel()

      // Schedule a new highlight operation after the debounce interval
      let workItem = DispatchWorkItem { [weak self] in
        self?.applyHighlighting()
      }
      highlightWorkItem = workItem

      // Execute after debounce interval on the main queue
      DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval, execute: workItem)
    }

    func applyHighlighting() {
      guard let textView = textView else { return }

      let currentText = textView.string
      let attributedString = NSMutableAttributedString(string: currentText)

      // Apply default attributes to the entire text
      let defaultAttributes: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 12),
        .foregroundColor: NSColor.labelColor,
      ]
      attributedString.setAttributes(defaultAttributes, range: NSRange(location: 0, length: attributedString.length))

      // Get highlighted ranges from the syntax highlighter
      let highlightedRanges = highlighter.highlight(text: currentText)

      // Apply each highlighted range's attributes
      for (range, attributes) in highlightedRanges {
        attributedString.addAttributes(attributes, range: range)
      }

      // Preserve the current cursor position and selection
      let selectedRange = textView.selectedRange()

      // Apply the attributed string to the text storage
      textView.textStorage?.setAttributedString(attributedString)

      // Restore the cursor position
      textView.setSelectedRange(selectedRange)
    }
  }
}

