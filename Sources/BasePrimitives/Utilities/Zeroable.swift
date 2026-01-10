//
//  Zeroable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/9/2025.
//

import Foundation


/// Protocol for types that can be treated as "zero" when nil
public protocol Zeroable {
  static var zero: Self { get }
}

extension Double: Zeroable {
  public static var zero: Double { 0.0 }
}

extension Optional where Wrapped: Zeroable {

  /// Applies an operation to two optionals, treating nil as zero
  public func combined<T>(
    with other: T?,
    using operation: (Wrapped, T) -> Wrapped
  ) -> Wrapped? where T: Zeroable {
    guard self != nil || other != nil else { return nil }
    
    let lhs = self ?? .zero
    let rhs = other ?? .zero
    return operation(lhs, rhs)
  }

  private func withDefault(_ defaultValue: Wrapped) -> Wrapped {
    return self ?? defaultValue
  }
}
