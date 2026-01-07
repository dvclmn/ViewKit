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
  /// Creates `EdgeInsets` by mapping horizontal/vertical inputs
  public func makeEdgeInsets(horizontal: CGFloat, vertical: CGFloat) -> EdgeInsets {
    switch self {
      case .widthIsHorizontal:
        return EdgeInsets(
          top: vertical,
          leading: horizontal,
          bottom: vertical,
          trailing: horizontal
        )

      case .heightIsHorizontal:
        return EdgeInsets(
          top: horizontal,
          leading: vertical,
          bottom: horizontal,
          trailing: vertical
        )
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
  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
  public func makeCGSize(horizontal: CGFloat, vertical: CGFloat) -> CGSize {
    switch self {
      case .widthIsHorizontal:
        return CGSize(width: horizontal, height: vertical)

      case .heightIsHorizontal:
        return CGSize(width: vertical, height: horizontal)

    }
  }

  // MARK: - CGPoint

  public func horizontalValue(for point: CGPoint) -> CGFloat {
    switch self {
      case .widthIsHorizontal: point.x
      case .heightIsHorizontal: point.y
    }
  }

  public func verticalValue(for point: CGPoint) -> CGFloat {
    switch self {
      case .widthIsHorizontal: point.y
      case .heightIsHorizontal: point.x
    }
  }
  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
  public func makeCGPoint(horizontal: CGFloat, vertical: CGFloat) -> CGPoint {
    switch self {
      case .widthIsHorizontal:
        return CGPoint(x: horizontal, y: vertical)

      case .heightIsHorizontal:
        return CGPoint(x: vertical, y: horizontal)

    }
  }

  // MARK: - CGRect
  public func horizontalLength(rect: CGRect) -> CGFloat {
    switch self {
      case .widthIsHorizontal: rect.size.width
      case .heightIsHorizontal: rect.size.height
    }
  }

  public func verticalLength(rect: CGRect) -> CGFloat {
    switch self {
      case .widthIsHorizontal: rect.size.height
      case .heightIsHorizontal: rect.size.width
    }
  }
  /// Creates a `CGRect` by mapping horizontal/vertical inputs
  //  public func makeCGSize(horizontal: CGFloat, vertical: CGFloat) -> CGRect {
  //    switch self {
  //      case .widthIsHorizontal:
  //        return CGSize(width: horizontal, height: vertical)
  //
  //      case .heightIsHorizontal:
  //        return CGSize(width: vertical, height: horizontal)
  //
  //    }
  //  }
}
