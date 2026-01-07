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
  public func makeEdgeInsets(h: CGFloat, v: CGFloat) -> EdgeInsets {
    switch self {
      case .widthIsHorizontal: EdgeInsets(top: v, leading: h, bottom: v, trailing: h)
      case .heightIsHorizontal: EdgeInsets(top: h, leading: v, bottom: h, trailing: v)
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
  public func makeCGSize(h: CGFloat, v: CGFloat) -> CGSize {
    switch self {
      case .widthIsHorizontal: CGSize(width: h, height: v)
      case .heightIsHorizontal: CGSize(width: v, height: h)

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
  public func makeCGPoint(h: CGFloat, v: CGFloat) -> CGPoint {
    switch self {
      case .widthIsHorizontal: CGPoint(x: h, y: v)
      case .heightIsHorizontal: CGPoint(x: v, y: h)
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
}
