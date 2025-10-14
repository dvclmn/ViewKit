//
//  Model+AxisConvention.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/9/2025.
//

import SwiftUI

/// A mapping between `Dimension` (width / height) and `Axis` (horizontal / vertical).
///
/// Why this exists:
/// - In most cases, "width" means "horizontal" and "height" means "vertical".
/// - But occasionally this is not the case (rotated coordinate systems, swapped
///  axes, certain drawing transforms), so it's risky to assume
/// - This `DimensionToAxisConvention` makes the convention
/// explicit, so there's less risk of confusion
///
/// - `.widthIsHorizontal`:
///     width → horizontal length
///     height → vertical length
///
/// - `.heightIsHorizontal`:
///     height → horizontal length
///     width → vertical length
///
/// This mapping means we can derive correct values from 'dimension-based'
/// type like  `CGSize`, `CGPoint`, `EdgeInsets` etc
public enum DimensionToAxisConvention {

  case widthIsHorizontal
  case heightIsHorizontal

  // MARK: - EdgeInsets
  public func horizontalLength(edgeInsets: EdgeInsets) -> CGFloat {
    switch self {
      case .widthIsHorizontal: edgeInsets.leading + edgeInsets.trailing
      case .heightIsHorizontal: edgeInsets.top + edgeInsets.bottom
    }
  }

  public func verticalLength(edgeInsets: EdgeInsets) -> CGFloat {
    switch self {
      case .widthIsHorizontal: edgeInsets.top + edgeInsets.bottom
      case .heightIsHorizontal: edgeInsets.leading + edgeInsets.trailing
    }
  }

  // MARK: - CGSize

  /// Returns the horizontal length from a size, according to the convention.
  public func horizontalLength(size: CGSize) -> CGFloat {
    switch self {
      case .widthIsHorizontal: size.width
      case .heightIsHorizontal: size.height
    }
  }

  /// Returns the vertical length from a size, according to the convention.
  public func verticalLength(size: CGSize) -> CGFloat {
    switch self {
      case .widthIsHorizontal: size.height
      case .heightIsHorizontal: size.width
    }
  }

  // MARK: - GridSize
  
  /// Returns the horizontal length from a size, according to the convention.
  public func horizontalLength(size: GridSize) -> GridLength {
    switch self {
      case .widthIsHorizontal: size.width
      case .heightIsHorizontal: size.height
    }
  }
  
  /// Returns the vertical length from a size, according to the convention.
  public func verticalLength(size: GridSize) -> GridLength {
    switch self {
      case .widthIsHorizontal: size.height
      case .heightIsHorizontal: size.width
    }
  }

  
  // MARK: - CGRect

  /// Returns the horizontal length from a size, according to the convention.
  public func horizontalLength(rect: CGRect) -> CGFloat {
    switch self {
      case .widthIsHorizontal: rect.size.width
      case .heightIsHorizontal: rect.size.height
    }
  }

  /// Returns the vertical length from a size, according to the convention.
  public func verticalLength(rect: CGRect) -> CGFloat {
    switch self {
      case .widthIsHorizontal: rect.size.height
      case .heightIsHorizontal: rect.size.width
    }
  }
}
