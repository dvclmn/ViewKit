//
//  SyntaxHighlighter.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/11/2025.
//

import SwiftUI

// MARK: - Basic Syntax Highlighter Implementation

/// A simple highlighter supporting inline code, keywords, strings, and numbers
public class BasicSyntaxHighlighter: SyntaxHighlighter {

  // Define colors for different syntax elements
  private let codeColor = NSColor.systemPurple
  private let keywordColor = NSColor.systemPink
  private let stringColor = NSColor.systemGreen
  private let numberColor = NSColor.systemBlue
  private let codeFont = NSFont.monospacedSystemFont(ofSize: 12, weight: .regular)
  
  public init() {}

  public func highlight(text: String) -> [NSRange: [NSAttributedString.Key: Any]] {
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
    // Match text between backticks, but NOT across newlines (inline syntax only)
    // [^`\n]+ means: one or more characters that are neither backtick nor newline
    let pattern = "`[^`\\n]+`"
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
    // Match strings in double quotes, but NOT across newlines (inline syntax)
    // [^"\n]* means: zero or more characters that are neither quote nor newline
    let pattern = "\"[^\"\\n]*\""
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
