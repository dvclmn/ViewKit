//
//  OmissionStrategy.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//


public enum OmissionStrategy {
  
  /// Removes all empty subsequences
  case omitAllEmpty
  
  /// Preserves empty subsequences except for empty last lines
  case omitLastLineIfEmpty
  
  /// Preserves all empty subsequences
  case doNotOmit
}

extension OmissionStrategy {
  /// What to pass into `split(..., omittingEmptySubsequences:)`
  fileprivate var omitsEmptySubsequencesDuringSplit: Bool {
    switch self {
      case .omitAllEmpty: true
      case .omitLastLineIfEmpty, .doNotOmit: false
    }
  }
  
  /// Applies any post-processing required by the strategy.
  fileprivate func finalise(_ parts: [Substring]) -> [Substring] {
    switch self {
      case .omitAllEmpty, .doNotOmit:
        return parts
        
      case .omitLastLineIfEmpty:
        guard let last = parts.last, last.isEmpty else { return parts }
        return Array(parts.dropLast())
    }
  }
  
  /// One stop shop: do the split using the strategy, then finalise.
  package func split(
    _ string: String,
    maxSplits: Int = .max,
    whereSeparator isSeparator: (Character) -> Bool
  ) -> [Substring] {
    let parts = string.split(
      maxSplits: maxSplits,
      omittingEmptySubsequences: omitsEmptySubsequencesDuringSplit,
      whereSeparator: isSeparator
    )
    return finalise(parts)
  }
  
  /// Convenience for separator-as-Character call sites.
  package func split(
    _ string: String,
    maxSplits: Int = .max,
    separator: Character
  ) -> [Substring] {
    split(string, maxSplits: maxSplits, whereSeparator: { $0 == separator })
  }
}
//extension OmissionStrategy {
//  public var shouldOmit: Bool {
//    switch self {
//      case .omitAllEmpty: true
//      case .omitLastLineIfEmpty: false
//      case .doNotOmit: false
//    }
//  }
//  
//  public func processString(_ string: String) -> String {
//    switch omissionStrategy {
//      case .omitAllEmpty, .doNotOmit:
//        return subsequence
//        
//      case .omitLastLineIfEmpty:
//        guard let lastLine = subsequence.last else { return subsequence }
//        let result = lastLine.isEmpty ? Array(subsequence.dropLast()) : subsequence
//        return result
//    }
//  }
//}
