//
//  Bounds.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

/// A type-safe key for influencing random generation beyond numeric bounds.
///
/// Create static keys in extensions to add new influences without colliding names.
/// 
/// Expresses the numeric domain from which random values may be drawn.
/// Use a single closed range for simple cases, or multiple disjoint ranges to
/// construct a composite domain.
public enum RandomDomain<T: BinaryFloatingPoint>: Hashable {
  case single(ClosedRange<T>)
  case multiple([ClosedRange<T>])
  
  /// Flattens to an array of ranges for algorithms that operate over sequences.
  public var ranges: [ClosedRange<T>] {
    switch self {
      case .single(let r): return [r]
      case .multiple(let rs): return rs
    }
  }
}
