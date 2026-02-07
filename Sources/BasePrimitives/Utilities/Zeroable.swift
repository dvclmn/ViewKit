//
//  Zeroable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/9/2025.
//

import Foundation

extension Optional where Wrapped: BinaryFloatingPoint {

  /// Applies an operation to two optional floats, treating nil as zero
  public func combined(
    with other: Wrapped?,
    using operation: (Wrapped, Wrapped) -> Wrapped
  ) -> Wrapped? {
    guard self != nil || other != nil else { return nil }

    let lhs = self ?? .zero
    let rhs = other ?? .zero
    return operation(lhs, rhs)
  }

  private func withDefault(_ defaultValue: Wrapped) -> Wrapped {
    return self ?? defaultValue
  }
}
