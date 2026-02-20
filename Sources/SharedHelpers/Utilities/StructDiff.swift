//
//  Diff.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/2/2026.
//

public func lineDiff(_ old: String, _ new: String) -> String {
  let a = old.split(separator: "\n", omittingEmptySubsequences: false)
  let b = new.split(separator: "\n", omittingEmptySubsequences: false)
  
  var out: [String] = []
  let n = max(a.count, b.count)
  
  for i in 0..<n {
    let line1 = i < a.count ? String(a[i]) : ""
    let line2 = i < b.count ? String(b[i]) : ""
    if line1 != line2 {
      out.append("Line \(i+1):\n  - \(line1)\n  + \(line2)")
    }
  }
  
  return out.isEmpty ? "No differences" : out.joined(separator: "\n")
}

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
