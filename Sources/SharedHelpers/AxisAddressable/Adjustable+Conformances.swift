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
          case .widthIsHorizontal: convention.makeCGPoint(
            horizontal: newValue,
            vertical: <#T##CGFloat#>
          )
//          case .widthIsHorizontal: CGPoint(x: newValue, y: y)
          //            return CGSize(width: newValue, height: height)

          case .heightIsHorizontal: convention.makeCGPoint(
            horizontal: <#T##CGFloat#>,
            vertical: newValue
          )
//          case .heightIsHorizontal: CGPoint(x: x, y: newValue)
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

extension GridPosition: AdjustableByAxis {
  
  public func value(
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Int {
    switch axis {
      case .horizontal:
        convention.horizontalIndex(for: self)
//        convention.horizontalValue(for: self)
      case .vertical:
        convention.verticalIndex(for: self)
//        convention.verticalValue(for: self)
    }
  }
  
  public func setting(
    _ newValue: Int,
    for axis: Axis2D,
    convention: AxisConvention
  ) -> Self {
    switch axis {
      case .horizontal:
        switch convention {
          case .widthIsHorizontal: convention.makeGridPosition(
            horizontal: <#T##Int#>,
            vertical: <#T##Int#>
          )
//          case .widthIsHorizontal: CGPoint(x: newValue, y: y)
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
