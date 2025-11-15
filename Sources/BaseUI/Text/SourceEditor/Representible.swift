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
  var debounceInterval: TimeInterval = 0.3 // Wait 300ms after typing stops
  
  // Convenience initializer with default behaviors
  public init(
    text: Binding<String>,
    highlighter: SyntaxHighlighter,
    debounceInterval: TimeInterval = 0.3
  ) {
    self._text = text
    self.highlighter = highlighter
    self.debounceInterval = debounceInterval
    // Include default quality-of-life behaviors
    self.inputBehaviors = [
      WrapSelectionBehavior(),
//      AutoIndentBehavior()
    ]
  }
  
  // Full initializer for custom behaviors
  public init(
    text: Binding<String>,
    highlighter: SyntaxHighlighter,
    inputBehaviors: [TextInputBehavior],
    debounceInterval: TimeInterval = 0.3
  ) {
    self._text = text
    self.highlighter = highlighter
    self.inputBehaviors = inputBehaviors
    self.debounceInterval = debounceInterval
  }
  
  public func makeNSView(context: Context) -> NSScrollView {
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
    textView.textContainer?.containerSize = NSSize(width: scrollView.contentSize.width, height: CGFloat.greatestFiniteMagnitude)
    
    scrollView.documentView = textView
    
    // Store the text view in the coordinator for later access
    context.coordinator.textView = textView
    
    return scrollView
  }
  
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
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
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(
      text: $text,
      highlighter: highlighter,
      inputBehaviors: inputBehaviors,
      debounceInterval: debounceInterval
    )
  }
 
}

