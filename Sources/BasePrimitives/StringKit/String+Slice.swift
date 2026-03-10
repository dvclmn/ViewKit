//
//  String+Slice.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

/// All these slicing methods interpret indices as zero-based integer offsets, clamp safely, and never trap.
extension StringProtocol {
  
  // MARK: - Full Ranges
  func slice(_ range: Range<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
  func slice(closedRange range: ClosedRange<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
  // MARK: - Partial Ranges
  func slice(upTo upper: Int) -> SubSequence {
    slice(start: 0, length: upper)
  }
  
  func slice(through upper: Int) -> SubSequence {
    slice(start: 0, length: upper + 1)
  }

  func slice(from lower: Int) -> SubSequence {
    let start = Swift.max(0, lower)
    return slice(start: start, length: count - start)
  }

  // MARK: - Core Helper
  
  /// Core slicing primitive.
  /// Interprets `start` and `length` as integer offsets,
  /// clamps safely, never traps.
  private func slice(start: Int, length: Int) -> SubSequence {
    let start = Swift.max(0, start)
    let length = Swift.max(0, length)
    return prefix(start + length).suffix(length)
  }
}
