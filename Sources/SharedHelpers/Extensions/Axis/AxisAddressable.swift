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
  ) -> CGSize {
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
