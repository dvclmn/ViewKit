//
//  Diff.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/2/2026.
//

import Foundation

private enum DiffKind: String {
  case added = "ADDED"
  case deleted = "DELETED"
  case modified = "MODIFIED"
}

public enum WhitespaceViewStrategy {
  case none
  case indentationOnly
  case all
}

// MARK: - Whitespace helpers

private func leadingWhitespace(_ line: String) -> Substring {
  var i = line.startIndex
  while i < line.endIndex {
    let ch = line[i]
    guard ch == " " || ch == "\t" else { break }
    i = line.index(after: i)
  }
  return line[..<i]
}

private func trailingWhitespaceMarker(for line: String) -> String {
  // Note: lineDiff splits on "\n", so newline isn't present; we only care about spaces/tabs.
  let trimmed = line.trimmingCharacters(in: .whitespaces)
  guard trimmed != line else { return "" }
  return " ⟵ trailing whitespace"
}

private func visualiseLeadingWhitespace(_ line: String) -> String {
  let lead = leadingWhitespace(line)
  let rest = line.dropFirst(lead.count)
  
  let leadVisible = lead
    .replacingOccurrences(of: "\t", with: "→\t")
    .replacingOccurrences(of: " ", with: "·")
  
  return leadVisible + rest
}

private func visualiseAllWhitespace(_ line: String) -> String {
  line
    .replacingOccurrences(of: "\t", with: "→\t")
    .replacingOccurrences(of: " ", with: "·")
}

// MARK: - Rendering

private func displayLine(
  _ line: String,
  whitespace: WhitespaceViewStrategy,
  showIndentation: Bool
) -> String {
  guard !line.isEmpty else { return "∅" }
  
  let marker = trailingWhitespaceMarker(for: line)
  
  switch whitespace {
    case .none:
      return line + marker
      
    case .indentationOnly:
      // Only decorate indentation if requested (i.e. it differs between old/new)
      return (showIndentation ? visualiseLeadingWhitespace(line) : line) + marker
      
    case .all:
      return visualiseAllWhitespace(line) + marker
  }
}

public func lineDiff(
  _ old: String,
  _ new: String,
  whitespace: WhitespaceViewStrategy = .indentationOnly,
  showKindPrefix: Bool = true
) -> String {
  let a = old.split(separator: "\n", omittingEmptySubsequences: false)
  let b = new.split(separator: "\n", omittingEmptySubsequences: false)
  
  var out: [String] = []
  let n = max(a.count, b.count)
  
  for i in 0..<n {
    let l1 = i < a.count ? String(a[i]) : ""
    let l2 = i < b.count ? String(b[i]) : ""
    
    guard l1 != l2 else { continue }
    
    let kind: DiffKind =
    if l1.isEmpty && !l2.isEmpty { .added }
    else if !l1.isEmpty && l2.isEmpty { .deleted }
    else { .modified }
    
    let prefix = showKindPrefix ? "\(kind.rawValue) " : ""
    
    // Only relevant for indentationOnly
    let indentationDiffers = leadingWhitespace(l1) != leadingWhitespace(l2)
    let showIndentation = (whitespace == .indentationOnly) && indentationDiffers
    
    out.append("""
    \(prefix)Line \(i+1):
      - \(displayLine(l1, whitespace: whitespace, showIndentation: showIndentation))
      + \(displayLine(l2, whitespace: whitespace, showIndentation: showIndentation))
    """)
  }
  
  return out.isEmpty ? "No differences" : out.joined(separator: "\n")
}
