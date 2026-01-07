//
//  Adjustable+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/1/2026.
//

import SwiftUI

// MARK: - Adjustable
extension CGSize: AdjustableByAxis {}
extension CGPoint: AdjustableByAxis {}

// MARK: - Addressable
extension CGSize: AxisAddressable {

  /// Adds a method with naming more suited to CGSize specifically
  public func length(
    along axis: Axis2D,
    convention: AxisConvention = .default
  ) -> CGFloat {
    self.value(along: axis, convention: convention)
  }

  public func value(
    along axis: Axis2D,
    convention: AxisConvention
  ) -> CGFloat {
    switch axis {
      case .horizontal: convention.horizontalLength(size: self)
      case .vertical: convention.verticalLength(size: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    along axis: Axis2D,
    convention: AxisConvention
  ) -> Self {

    switch axis {
      case .horizontal:
        /// Keep the current vertical, update horizontal
        return convention.makeCGSize(
          h: newValue,
          v: convention.verticalLength(size: self)
        )
      case .vertical:
        /// Keep the current horizontal, update vertical
        return convention.makeCGSize(
          h: convention.horizontalLength(size: self),
          v: newValue
        )
    }
  }

}

// MARK: - CGPoint
extension CGPoint: AxisAddressable {

  public func value(
    along axis: Axis2D,
    convention: AxisConvention
  ) -> CGFloat {
    switch axis {
      case .horizontal: convention.horizontalValue(for: self)
      case .vertical: convention.verticalValue(for: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    along axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        /// Keep the current vertical, update horizontal
        return convention.makeCGPoint(
          h: newValue,
          v: convention.verticalValue(for: self)
        )
      case .vertical:
        /// Keep the current horizontal, update vertical
        return convention.makeCGPoint(
          h: convention.horizontalValue(for: self),
          v: newValue
        )
    }
  }
}

// MARK: - GridPosition
extension GridPosition: AdjustableByGridAxis {

  public func value(along axis: Axis2D, convention: GridAxisConvention) -> Int {
    switch axis {
      case .horizontal: return convention.horizontalValue(for: self)
      case .vertical: return convention.verticalValue(for: self)
    }
  }

  public func setting(
    _ newValue: Int,
    along axis: Axis2D,
    convention: GridAxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        return convention.makeGridPosition(
          h: newValue,
          v: convention.verticalValue(for: self)
        )
      case .vertical:
        return convention.makeGridPosition(
          h: convention.horizontalValue(for: self),
          v: newValue
        )
    }
  }

}

extension GridSize: AdjustableByGridAxis {

  public func value(along axis: Axis2D, convention: GridAxisConvention) -> GridLength {
    switch axis {
      case .horizontal: return convention.horizontalLength(gridSize: self)
      case .vertical: return convention.verticalLength(gridSize: self)
    }
  }

  public func setting(
    _ newValue: GridLength,
    along axis: Axis2D,
    convention: GridAxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        return convention.makeGridSize(
          h: newValue,
          v: convention.verticalLength(gridSize: self)
        )
      case .vertical:
        return convention.makeGridSize(
          h: convention.horizontalLength(gridSize: self),
          v: newValue
        )
    }
  }
}

// MARK: - UnitPoint
extension UnitPoint: AxisAddressable {

  public func value(
    along axis: Axis2D,
    convention: AxisConvention
  ) -> CGFloat {
    switch axis {
      case .horizontal: convention.horizontalValue(for: self)
      case .vertical: convention.verticalValue(for: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    along axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        /// Keep the current vertical, update horizontal
        return convention.makeUnitPoint(
          h: newValue,
          v: convention.verticalValue(for: self)
        )
      case .vertical:
        /// Keep the current horizontal, update vertical
        return convention.makeUnitPoint(
          h: convention.horizontalValue(for: self),
          v: newValue
        )
    }
  }
}
