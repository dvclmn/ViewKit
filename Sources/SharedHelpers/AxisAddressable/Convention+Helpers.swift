//
//  Convention+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import SwiftUI

//extension AxisConvention {
//  
//  // MARK: - EdgeInsets
//  public func horizontalLength(edgeInsets: EdgeInsets) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: edgeInsets.leading + edgeInsets.trailing
//      case .heightIsHorizontal: edgeInsets.top + edgeInsets.bottom
//    }
//  }
//  
//  public func verticalLength(edgeInsets: EdgeInsets) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: edgeInsets.top + edgeInsets.bottom
//      case .heightIsHorizontal: edgeInsets.leading + edgeInsets.trailing
//    }
//  }
//  /// Creates `EdgeInsets` by mapping horizontal/vertical inputs
//  public func makeEdgeInsets(
//    h: CGFloat,
//    v: CGFloat
//  ) -> EdgeInsets {
//    switch self {
//      case .widthIsHorizontal: EdgeInsets(top: v, leading: h, bottom: v, trailing: h)
//      case .heightIsHorizontal: EdgeInsets(top: h, leading: v, bottom: h, trailing: v)
//    }
//  }
//  
//  // MARK: - CGSize
//  
//  /// Returns the horizontal length from a size, according to the convention.
//  public func horizontalLength(size: CGSize) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: size.width
//      case .heightIsHorizontal: size.height
//    }
//  }
//  
//  /// Returns the vertical length from a size, according to the convention.
//  public func verticalLength(size: CGSize) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: size.height
//      case .heightIsHorizontal: size.width
//    }
//  }
//  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
//  public func makeCGSize(h: CGFloat, v: CGFloat) -> CGSize {
//    switch self {
//      case .widthIsHorizontal: CGSize(width: h, height: v)
//      case .heightIsHorizontal: CGSize(width: v, height: h)
//        
//    }
//  }
//  
//  // MARK: - CGPoint
//  public func horizontalValue(for point: CGPoint) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: point.x
//      case .heightIsHorizontal: point.y
//    }
//  }
//  
//  public func verticalValue(for point: CGPoint) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: point.y
//      case .heightIsHorizontal: point.x
//    }
//  }
//  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
//  public func makeCGPoint(h: CGFloat, v: CGFloat) -> CGPoint {
//    switch self {
//      case .widthIsHorizontal: CGPoint(x: h, y: v)
//      case .heightIsHorizontal: CGPoint(x: v, y: h)
//    }
//  }
//  
//  // MARK: - CGRect
//  public func horizontalLength(rect: CGRect) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: rect.size.width
//      case .heightIsHorizontal: rect.size.height
//    }
//  }
//  
//  public func verticalLength(rect: CGRect) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: rect.size.height
//      case .heightIsHorizontal: rect.size.width
//    }
//  }
//  
//  // MARK: - UnitPoint
//  public func horizontalValue(for unitPoint: UnitPoint) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: unitPoint.x
//      case .heightIsHorizontal: unitPoint.y
//    }
//  }
//  
//  public func verticalValue(for unitPoint: UnitPoint) -> CGFloat {
//    switch self {
//      case .widthIsHorizontal: unitPoint.y
//      case .heightIsHorizontal: unitPoint.x
//    }
//  }
//  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
//  public func makeUnitPoint(h: CGFloat, v: CGFloat) -> UnitPoint {
//    switch self {
//      case .widthIsHorizontal: UnitPoint(x: h, y: v)
//      case .heightIsHorizontal: UnitPoint(x: v, y: h)
//    }
//  }
//}
//
//// MARK: - Grid Axis
//extension GridAxisConvention {
//  
//  /// Returns the horizontal index (usually column) based on the convention.
//  public func horizontalValue(for position: GridPosition) -> Int {
//    switch self {
//      case .columnIsHorizontal: position.column
//      case .rowIsHorizontal: position.row
//    }
//  }
//  
//  /// Returns the vertical index (usually row) based on the convention.
//  public func verticalValue(for position: GridPosition) -> Int {
//    switch self {
//      case .columnIsHorizontal: position.row
//      case .rowIsHorizontal: position.column
//    }
//  }
//  
//  /// Creates a GridPosition by mapping horizontal/vertical inputs to row/column storage.
//  public func makeGridPosition(h: Int, v: Int) -> GridPosition {
//    switch self {
//      case .columnIsHorizontal: GridPosition(row: v, column: h)
//      case .rowIsHorizontal: GridPosition(row: h, column: v)
//    }
//  }
//  
//  // MARK: - GridSize
//  
//  /// Returns the horizontal length from a size, according to the convention.
//  public func horizontalLength(gridSize: GridSize) -> GridLength {
//    switch self {
//      case .columnIsHorizontal: gridSize.columns
//      case .rowIsHorizontal: gridSize.rows
//    }
//  }
//  
//  /// Returns the vertical length from a size, according to the convention.
//  public func verticalLength(gridSize: GridSize) -> GridLength {
//    switch self {
//      case .columnIsHorizontal: gridSize.rows
//      case .rowIsHorizontal: gridSize.columns
//    }
//  }
//  
//  public func makeGridSize(h: GridLength, v: GridLength) -> GridSize {
//    switch self {
//      case .columnIsHorizontal: GridSize(columns: h, rows: v)
//      case .rowIsHorizontal: GridSize(columns: v, rows: h)
//        
//    }
//  }
//  
//  //  public func makeGridSize(
//  //    h: CGFloat,
//  //    v: CGFloat,
//  //    unitSize: CGSize
//  //  ) -> GridSize {
//  //    switch self {
//  //      case .columnIsHorizontal:
//  //        return GridSize(columns: h, rows: v)
//  //
//  //      case .rowIsHorizontal:
//  //        return GridSize(columns: v, rows: h)
//  //
//  //    }
//  //  }
//}
