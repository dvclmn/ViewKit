//
//  Diff.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/2/2026.
//

private enum DiffKind: String {
  case added = "ADDED"
  case deleted = "DELETED"
  case modified = "MODIFIED"
}

enum WhitespaceViewStrategy {
  case none
  case indentationOnly
  case all
}

private func trailingWhitespaceMarker(for line: String) -> String {
  // Consider any trailing spaces/tabs as noteworthy
  let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
  guard trimmed != line else { return "" }
  return " ⟵ trailing whitespace"
}

private func visualiseIndentation(_ line: String) -> String {
  // Replace only the *leading* whitespace.
  // Spaces -> ·, tabs -> →\t (keeps tab width somewhat intuitive)
  var i = line.startIndex
  while i < line.endIndex {
    let ch = line[i]
    if ch == " " || ch == "\t" {
      i = line.index(after: i)
      continue
    }
    break
  }
  
  let leading = String(line[..<i])
  let rest = String(line[i...])
  
  let leadingVisible = leading
    .replacingOccurrences(of: "\t", with: "→\t")
    .replacingOccurrences(of: " ", with: "·")
  
  return leadingVisible + rest
}

private func visualiseAllWhitespace(_ line: String) -> String {
  line
    .replacingOccurrences(of: "\t", with: "→\t")
    .replacingOccurrences(of: " ", with: "·")
}

private func displayLine(_ line: String, whitespace: WhitespaceViewStrategy) -> String {
  guard !line.isEmpty else { return "∅" }
  
  let marker = trailingWhitespaceMarker(for: line)
  
  switch whitespace {
    case .none:
      return line + marker
    case .indentationOnly:
      return visualiseIndentation(line) + marker
    case .all:
      return visualiseAllWhitespace(line) + marker
  }
}

func lineDiff(
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
    
    out.append("""
    \(prefix)Line \(i+1):
      - \(displayLine(l1, whitespace: whitespace))
      + \(displayLine(l2, whitespace: whitespace))
    """)
  }
  
  return out.isEmpty ? "No differences" : out.joined(separator: "\n")
}
//private func visualised(_ line: String) -> String {
//  if line.isEmpty { return "∅" }
//  
//  /// Replace whitespace with visible glyphs
//  let hasTrailingWhitespace = line.last.map { $0 == " " || $0 == "\t" } ?? false
//  
//  var result = line
//    .replacingOccurrences(of: "\t", with: "→\t")
//    .replacingOccurrences(of: " ", with: "·")
//  
//  if hasTrailingWhitespace {
//    result += " ⟵ trailing whitespace"
//  }
//  
//  return result
//}

//private func show(_ line: String, showWhitespace: Bool) -> String {
//  showWhitespace ? visualised(line) : (line.isEmpty ? "∅" : line)
//}
//
//public func lineDiff(
//  _ old: String,
//  _ new: String,
//  showWhitespace: Bool = true,
//  showKindPrefix: Bool = true
//) -> String {
//  let a = old.split(separator: "\n", omittingEmptySubsequences: false)
//  let b = new.split(separator: "\n", omittingEmptySubsequences: false)
//  
//  var out: [String] = []
//  let n = max(a.count, b.count)
//  
//  for i in 0..<n {
//    let l1 = i < a.count ? String(a[i]) : ""
//    let l2 = i < b.count ? String(b[i]) : ""
//    
//    guard l1 != l2 else { continue }
//    
//    let kind: DiffKind =
//    if l1.isEmpty && !l2.isEmpty { .added }
//    else if !l1.isEmpty && l2.isEmpty { .deleted }
//    else { .modified }
//    
//    let prefix = showKindPrefix ? "\(kind.rawValue) " : ""
//    
//    out.append("""
//    \(prefix)Line \(i+1):
//      - \(show(l1, showWhitespace: showWhitespace))
//      + \(show(l2, showWhitespace: showWhitespace))
//    """)
//  }
//  
//  return out.isEmpty ? "No differences" : out.joined(separator: "\n")
//}

//public func diff<T>(_ lhs: T, _ rhs: T) -> String {
//  let m1 = Mirror(reflecting: lhs)
//  let m2 = Mirror(reflecting: rhs)
//
//  precondition(
//    m1.subjectType == m2.subjectType,
//    "Diff requires same types"
//  )
//
//  var lines: [String] = []
//
//  for (c1, c2) in zip(m1.children, m2.children) {
//    guard let label = c1.label else { continue }
//
//    // Compare via string representation
//    let v1 = String(describing: c1.value)
//    let v2 = String(describing: c2.value)
//
//    if v1 != v2 {
//      lines.append("  \(label): \(v1) → \(v2)")
//    }
//  }
//
//  return lines.isEmpty
//    ? "No differences"
//    : "\(m1.subjectType):\n" + lines.joined(separator: "\n")
//}
//
//
//public func diff<T: Equatable>(_ lhs: T, _ rhs: T) -> String {
//  lhs == rhs ? "No differences" : "\(T.self):\n  value: \(lhs) → \(rhs)"
//}
