//
//  Representible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

// MARK: - NSViewRepresentable Wrapper

@MainActor
public struct SyntaxHighlightingTextView: NSViewRepresentable {
  @Binding public var text: String
  var highlighter: SyntaxHighlighter
  var inputBehaviors: [TextInputBehavior]
  var debounceInterval: TimeInterval = 0.3
  //  let font: Font
  let fontSize: CGFloat

  public init(
    text: Binding<String>,
    highlighter: SyntaxHighlighter,
    inputBehaviors: [TextInputBehavior] = [],
    debounceInterval: TimeInterval = 0.3,
    //    font: Font,
    fontSize: CGFloat = 14,
  ) {
    self._text = text
    self.highlighter = highlighter
    self.inputBehaviors = inputBehaviors
    self.debounceInterval = debounceInterval
    //    self.font = font
    self.fontSize = fontSize
  }

  public func makeNSView(context: Context) -> NSScrollView {

    /// Create the scroll view container
    let scrollView = NSScrollView()
    scrollView.hasVerticalScroller = true
    scrollView.hasHorizontalScroller = false
    scrollView.autohidesScrollers = true
    scrollView.borderType = .noBorder
    scrollView.drawsBackground = false

    /// Create and configure the text view
    let textView = NSTextView()
    textView.delegate = context.coordinator
    textView.isEditable = true
    textView.isSelectable = true
    textView.isRichText = false
    textView.font = NSFont.monospacedSystemFont(ofSize: fontSize, weight: .regular)
    textView.textColor = NSColor.labelColor
    textView.drawsBackground = false
    textView.backgroundColor = NSColor.clear
    textView.isAutomaticQuoteSubstitutionEnabled = false
    textView.isAutomaticDashSubstitutionEnabled = false
    textView.isAutomaticSpellingCorrectionEnabled = false

    /// Configure for continuous wrapping
    textView.maxSize = NSSize(
      width: CGFloat.greatestFiniteMagnitude,
      height: CGFloat.greatestFiniteMagnitude
    )
    textView.isVerticallyResizable = true
    textView.isHorizontallyResizable = false
    textView.textContainer?.widthTracksTextView = true
    textView.textContainer?.containerSize = NSSize(
      width: scrollView.contentSize.width,
      height: CGFloat.greatestFiniteMagnitude
    )

    scrollView.documentView = textView

    /// Store the text view in the coordinator for later access
    context.coordinator.textView = textView

    return scrollView
  }

  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    guard let textView = scrollView.documentView as? NSTextView else { return }

    /// Only update if the text has changed externally (not from typing)
    if textView.string != text {
      /// Preserve cursor position
      let selectedRange = textView.selectedRange()
      textView.string = text
      textView.setSelectedRange(selectedRange)

      /// Apply highlighting immediately for external changes
      context.coordinator.applyHighlighting()
    }
  }

  public func makeCoordinator() -> Coordinator {
    Coordinator(
      text: $text,
      highlighter: highlighter,
      inputBehaviors: inputBehaviors,
      debounceInterval: debounceInterval,
      fontSize: fontSize
    )
  }

}
