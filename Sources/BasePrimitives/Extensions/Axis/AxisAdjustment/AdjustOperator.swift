//
//  AdjustOperator.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/1/2026.
//

/// ```
/// point.adjust(.horizontal, using: +20)
/// point.adjust(.vertical, using: *0.5)
///
/// ```
public struct Operation<T> {
  let apply: (T) -> T
}

public func +<T: AdditiveArithmetic>(rhs: T) -> Operation<T> {
  Operation { $0 + rhs }
}

public func *<T: Numeric>(rhs: T) -> Operation<T> {
  Operation { $0 * rhs }
}
