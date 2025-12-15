//
//  AxisAddressable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

public protocol AxisAddressable {
  associatedtype Value: BinaryFloatingPoint
  func value(
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Value

  func setting(
    _ value: Value,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self
}

// MARK: - Conformances
extension CGSize: AxisAddressable {

  public func value(
    for axis: Axis2D,
    convention: AxisConvention
  ) -> CGFloat {
    switch axis {
      case .horizontal:
        convention.horizontalLength(size: self)
      case .vertical:
        convention.verticalLength(size: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    for axis: Axis2D,
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
      case .horizontal:
        convention.horizontalValue(for: self)
      case .vertical:
        convention.verticalValue(for: self)
    }
  }

  public func setting(
    _ newValue: CGFloat,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        switch convention {
          case .widthIsHorizontal: CGPoint(x: newValue, y: y)
          //            return CGSize(width: newValue, height: height)

          case .heightIsHorizontal: CGPoint(x: x, y: newValue)
        //            return CGSize(width: width, height: newValue)
        }

      case .vertical:
        switch convention {
          case .widthIsHorizontal: CGPoint(x: x, y: newValue)
          case .heightIsHorizontal: CGPoint(x: newValue, y: y)
        }
    }
  }
}
