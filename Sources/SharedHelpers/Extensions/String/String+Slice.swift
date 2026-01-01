//
//  String+Slice.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/1/2026.
//

import Foundation

extension StringProtocol {
  func slice(_ range: Range<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
  func slice(_ range: ClosedRange<Int>) -> SubSequence {
    slice(start: range.lowerBound, length: range.count)
  }
  
//  func slice(_ range: Range<Int>) -> SubSequence {
//    let start = Swift.max(0, range.lowerBound)
//    let length = Swift.max(0, range.count)
//    return prefix(start + length).suffix(length)
//  }
//
//  func slice(closedRange range: ClosedRange<Int>) -> SubSequence {
//    slice(Range(range))
//  }

  //  func slice(_ range: Range<Int>) -> SubSequence {
  //    slice(closedRange: ClosedRange(range))
  //  }
  //
  //  func slice(closedRange range: ClosedRange<Int>) -> SubSequence {
  //    let start = Swift.max(0, range.lowerBound)
  //    let length = Swift.max(0, range.count)
  //    return prefix(start + length).suffix(length)
  //  }

  func slice(upTo upper: Int) -> SubSequence {
    prefix(Swift.max(0, upper))
  }

  func slice(through upper: Int) -> SubSequence {
    prefix(Swift.max(0, upper + 1))
  }

  func slice(from lower: Int) -> SubSequence {
    suffix(Swift.max(0, count - lower))
  }
}

// Helper
extension StringProtocol {
  
  private func slice(start: Int, length: Int) -> SubSequence {
    let start = Swift.max(0, start)
    let length = Swift.max(0, length)
    return prefix(start + length).suffix(length)
  }
}
