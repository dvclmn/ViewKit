//
//  CGSizeComparisons.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/7/2025.
//

import Foundation

extension CGSize {


  // MARK: - Either dimension
  public func eitherDimensionIsGreaterThan(_ value: CGFloat) -> Bool {
    compareDimensions(to: value, using: >, matchMode: .any)
  }
  public func eitherDimensionIsGreaterThan(_ other: CGSize) -> Bool {
    compareDimensions(to: other, using: >, matchMode: .any)
  }
  public func eitherDimensionIsLessThan(_ value: CGFloat) -> Bool {
    compareDimensions(to: value, using: <, matchMode: .any)
  }
  public func eitherDimensionIsLessThan(_ other: CGSize) -> Bool {
    compareDimensions(to: other, using: <, matchMode: .any)
  }

  // MARK: - Both dimensions
  public func bothDimensionsAreGreaterThan(_ value: CGFloat) -> Bool {
    compareDimensions(to: value, using: >, matchMode: .both)
  }
  public func bothDimensionsAreGreaterThan(_ other: CGSize) -> Bool {
    compareDimensions(to: other, using: >, matchMode: .both)
  }
  public func bothDimensionsAreLessThan(_ value: CGFloat) -> Bool {
    compareDimensions(to: value, using: <, matchMode: .both)
  }
  public func bothDimensionsAreLessThan(_ other: CGSize) -> Bool {
    compareDimensions(to: other, using: <, matchMode: .both)
  }
}

extension CGSize {

  enum DimensionMatchMode {
    case any
    case both

    func evaluate(lhs: Bool, rhs: Bool) -> Bool {
      switch self {
        case .any: return lhs || rhs
        case .both: return lhs && rhs
      }
    }
  }

  private func compareDimensions<T: BinaryFloatingPoint>(
    to value: T,
    using comparison: (CGFloat, CGFloat) -> Bool,
    matchMode: DimensionMatchMode
  ) -> Bool {
    let widthResult = comparison(width, CGFloat(value))
    let heightResult = comparison(height, CGFloat(value))

    return switch matchMode {
      case .any: widthResult || heightResult
      case .both: widthResult && heightResult
    }
  }

  private func compareDimensions(
    to other: Self,
    using comparison: (CGFloat, CGFloat) -> Bool,
    matchMode: DimensionMatchMode
  ) -> Bool {
    let widthResult = comparison(width, other.width)
    let heightResult = comparison(height, other.height)

    return switch matchMode {
      case .any: widthResult || heightResult
      case .both: widthResult && heightResult
    }
  }
}
