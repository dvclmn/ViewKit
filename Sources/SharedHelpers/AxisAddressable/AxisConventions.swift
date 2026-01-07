//
//  Model+AxisConvention.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/9/2025.
//

import SwiftUI

/// A mapping between `Dimension` (width / height) and `Axis` (horizontal / vertical).
///
/// This aims to answer the question:
/// “Given this dimension-based structure, which scalar corresponds to which axis?”
///
/// In most cases, "width" means "horizontal" and "height" means "vertical".
/// But occasionally this is not the case (rotated coordinate systems, swapped
///  axes, certain drawing transforms), so it's risky to assume.
///
/// `AxisConvention` makes the convention explicit, so there's less risk of confusion
///
/// `.widthIsHorizontal`:
///    width → horizontal length
///    height → vertical length
///
/// `.heightIsHorizontal`:
///    height → horizontal length
///    width → vertical length
///
/// Enables deriving correct values from types like
/// `CGSize`, `CGPoint`, `EdgeInsets` etc
public enum AxisConvention: Sendable {

  case widthIsHorizontal
  case heightIsHorizontal

  public static let `default`: Self = .widthIsHorizontal
}

extension AxisConvention {

  public var widthAxis: Axis2D {
    switch self {
      case .widthIsHorizontal: .horizontal
      case .heightIsHorizontal: .vertical
    }
  }

  public var heightAxis: Axis2D {
    switch self {
      case .widthIsHorizontal: .vertical
      case .heightIsHorizontal: .horizontal
    }
  }
}

/// This exists alongside `AxisConvention`, to represent index
/// space, where `AxisConvention` represents 'dimension' space
///
/// In a standard grid, Columns typically represent the horizontal index (X)
/// and Rows represent the vertical index (Y)
public enum GridAxisConvention: Sendable {
  case columnIsHorizontal
  case rowIsHorizontal

  public static let `default`: Self = .columnIsHorizontal
}

extension GridAxisConvention {

  public var rowAxis: Axis2D {
    switch self {
      case .columnIsHorizontal: .vertical
      case .rowIsHorizontal: .horizontal
    }
  }

  public var columnAxis: Axis2D {
    switch self {
      case .columnIsHorizontal: .horizontal
      case .rowIsHorizontal: .vertical
    }
  }
}
