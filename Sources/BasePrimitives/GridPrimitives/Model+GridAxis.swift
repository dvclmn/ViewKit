//
//  Model+GridDimension.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

/// Note: `GridAxis` is about how indices progress across the grid,
/// not about how the things themselves are shaped.
///
/// Even though a column is (in isolation) a 'vertical thing'.
///
/// ```
///    x →  0   1   2
///  y    ┌───┬───┬───┐
///  ↓    │   │   │   │   row 0
///       ├───┼───┼───┤
///       │   │   │   │   row 1
///       ├───┼───┼───┤
///       │   │   │   │   row 2
///
/// ```
public enum GridAxis: String, ModelBase, CaseIterable, Identifiable {
  case horizontal  // Column
  case vertical  // Row

//  public static let fixedLength: CGFloat = 18

  public var id: String { rawValue }

  public var locationKeyPath: WritableKeyPath<CGPoint, CGFloat> {
    switch self {
      case .horizontal: \.x
      case .vertical: \.y
    }
  }

  public var sizeKeyPath: KeyPath<CGSize, CGFloat> {
    switch self {
      case .horizontal: \.width
      case .vertical: \.height
    }
  }

  public var opposing: Self {
    switch self {
      case .horizontal: .vertical
      case .vertical: .horizontal
    }
  }

  /// The 'actual' value, for the corresponding property, from the `GridCanvas` itself
  public var dimensionsKeyPath: WritableKeyPath<GridDimensions, Int> {
    switch self {
      case .horizontal: \.width
      case .vertical: \.height
    }
  }

  public var positionKeyPath: KeyPath<GridPosition, Int> {
    switch self {
      case .horizontal: \.column
      case .vertical: \.row
    }
  }

//  public var numberingFrameSize: (CGFloat?, CGFloat?) {
//    return switch self {
//      case .horizontal: (nil, Self.fixedLength)
//      case .vertical: (Self.fixedLength, nil)
//    }
//  }

  public var cellNumberTextAlignment: UnitPoint {
    switch self {
      case .horizontal: .center
      case .vertical: .trailing
    }
  }

  public var numberingShapeAlignment: Alignment {
    switch self {
      case .horizontal: .top
      case .vertical: .leading
    }
  }

  public func cellNumberPositioning(
    _ cellIndex: Int,
    cellSize: CGSize
  ) -> CGPoint {
    switch self {
      case .horizontal:
        CGPoint(
          x: CGFloat(cellIndex - 1) * cellSize.width,
          y: 0  // Columns align along the Y axis
        )

      case .vertical:
        CGPoint(
          x: 0,  // Rows align down the X axis
          y: CGFloat(cellIndex - 1) * cellSize.height
        )
    }
  }

  public func axisOffset(
    frameInViewport frame: CGRect,
  ) -> CGSize {
    return switch self {
      case .horizontal:
        CGSize(
          width: frame.origin.x,
          height: 0
        )
      case .vertical:
        CGSize(
          /// Width is zero as I don't want to decouple
          width: 0,
          height: frame.origin.y
        )

    }
  }

  public func hasOverflow(
    canvasFrameInViewport: CGRect?,
    buffer: CGFloat,
  ) -> Bool {

    guard let canvasFrameInViewport else { return false }
    switch self {
      case .horizontal:
        let minX = canvasFrameInViewport.minX - buffer
        let hasOverflow: Bool = minX < 0
        return hasOverflow

      case .vertical:
        let minY = canvasFrameInViewport.minY - buffer
        let hasOverflow: Bool = minY < 0
        return hasOverflow
    }
  }

}

/// Metadata
extension GridAxis {

  public var name: String {
    switch self {
      case .horizontal: "Width"
      case .vertical: "Height"
    }
  }

  public var icon: String {
    switch self {
      case .horizontal: "arrow.left.and.right.text.vertical"
      case .vertical: "arrow.up.and.down.text.horizontal"
    }
  }

  public var altName: String {
    switch self {
      case .horizontal: "Columns"
      case .vertical: "Rows"
    }
  }

  public var altName02: String {
    switch self {
      case .horizontal: "Horizontal"
      case .vertical: "Vertical"
    }
  }
}
