//
//  Comparable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import Foundation

extension Comparable {

  /// Returns `self` clamped to the provided range.
  /// - Precondition: The range must be valid (i.e., lowerBound <= upperBound).
  /// Note: This is *not* the same as normalising
  public func clamped(to range: ClosedRange<Self>) -> Self {
    return clamped(range.lowerBound, range.upperBound)
  }

  /// `min` == `lowerBound`
  /// `max` == `upperBound`
  public func clamped(_ lower: Self, _ upper: Self) -> Self {
    guard lower < upper else { return self }
    return Swift.min(upper, Swift.max(lower, self))
  }

//  public func clamped(_ lower: Self) -> Self {
//    return Swift.max(lower, self)
//  }

}

extension Comparable where Self: BinaryFloatingPoint {

  public func clamped(toIntRange range: Range<Int>) -> Self {
    return clamped(Self(range.lowerBound), Self(range.upperBound))
  }

  /// Returns `self` clamped to the provided range, or `nil` if either bound is not finite.
  /// - Precondition: The range must be valid (i.e., lowerBound <= upperBound).
  public func clampedIfFinite(to range: ClosedRange<Self>) -> Self? {
    precondition(
      range.lowerBound <= range.upperBound,
      "Invalid range: lowerBound must be less than or equal to upperBound.")
    guard range.lowerBound.isFinite, range.upperBound.isFinite else { return nil }
    return min(max(self, range.lowerBound), range.upperBound)
  }

}
