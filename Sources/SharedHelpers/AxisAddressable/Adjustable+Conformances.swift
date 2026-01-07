//
//  Adjustable+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/1/2026.
//

import Foundation

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
      case .horizontal:
        convention.horizontalLength(size: self)
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
        switch convention {
          case .widthIsHorizontal:
            return CGSize(width: newValue, height: height)
          case .heightIsHorizontal:
            return CGSize(width: width, height: newValue)
        }

      case .vertical:
        switch convention {
          case .widthIsHorizontal:
            return CGSize(width: width, height: newValue)
          case .heightIsHorizontal:
            return CGSize(width: newValue, height: height)
        }
    }
  }
  
}

extension CGPoint: AxisAddressable {

  public func value(
    for axis: Axis2D,
    convention: AxisConvention
  ) -> CGFloat {
    switch axis {
      case .horizontal: convention.horizontalValue(for: self)
      case .vertical: convention.verticalValue(for: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        /// Keep the current vertical, update horizontal
        return convention.makeCGPoint(
          horizontal: newValue,
          vertical: convention.verticalValue(for: self)
        )
      case .vertical:
        /// Keep the current horizontal, update vertical
        return convention.makeCGPoint(
          horizontal: convention.horizontalValue(for: self),
          vertical: newValue
        )
    }
  }

  //  public func setting(
  //    _ newValue: CGFloat,
  //    for axis: Axis2D,
  //    convention: AxisConvention
  //  ) -> Self {
  //    switch axis {
  //      case .horizontal:
  //        switch convention {
  //          case .widthIsHorizontal: convention.makeCGPoint(
  //            horizontal: newValue,
  //            vertical: <#T##CGFloat#>
  //          )
  ////          case .widthIsHorizontal: CGPoint(x: newValue, y: y)
  //          //            return CGSize(width: newValue, height: height)
  //
  //          case .heightIsHorizontal: convention.makeCGPoint(
  //            horizontal: <#T##CGFloat#>,
  //            vertical: newValue
  //          )
  ////          case .heightIsHorizontal: CGPoint(x: x, y: newValue)
  //        //            return CGSize(width: width, height: newValue)
  //        }
  //
  //      case .vertical:
  //        switch convention {
  //          case .widthIsHorizontal: CGPoint(x: x, y: newValue)
  //          case .heightIsHorizontal: CGPoint(x: newValue, y: y)
  //        }
  //    }
  //  }
}

extension GridPosition: AdjustableByAxis {

  public func value(for axis: Axis2D, convention: AxisConvention) -> Int {
    switch axis {
      case .horizontal: return convention.horizontalIndex(for: self)
      case .vertical: return convention.verticalIndex(for: self)
    }
  }

  public func setting(
    _ newValue: Int,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        return convention.makeGridPosition(
          horizontal: newValue,
          vertical: convention.verticalIndex(for: self)
        )
      case .vertical:
        return convention.makeGridPosition(
          horizontal: convention.horizontalIndex(for: self),
          vertical: newValue
        )
    }
  }

}

extension GridSize: AdjustableByAxis {

  public func value(for axis: Axis2D, convention: AxisConvention) -> GridLength {
    switch axis {
      case .horizontal: return convention.horizontalLength(gridSize: self)
      case .vertical: return convention.verticalLength(gridSize: self)
    }
  }

  public func setting(
    _ newValue: GridLength,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        return convention.makeGridSize(
          horizontal: newValue,
          vertical: convention.verticalLength(gridSize: self)
        )
      case .vertical:
        return convention.makeGridSize(
          horizontal: convention.horizontalLength(gridSize: self),
          vertical: newValue
        )
    }
  }

}
