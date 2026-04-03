//
//  GeometryAxis+Exts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/3/2026.
//

import InteractionKit
import Foundation

extension GeometryAxis {
  public func cellNumberPositioning(
    _ cellIndex: Int,
    cellSize: CGSize
  ) -> CGPoint {
    switch self {
      case .horizontal:
        GridScreenConversion.screenPoint(
          for: GridPosition(column: cellIndex - 1, row: 0),
          unitSize: cellSize
        )
        
      case .vertical:
        GridScreenConversion.screenPoint(
          for: GridPosition(column: 0, row: cellIndex - 1),
          unitSize: cellSize
        )
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

}


// MARK: - Index-based conformace
extension GridPosition: AxisKeyPathWritable {
  public static var primaryWritableKey: WritableKeyPath<Self, Int> { \.column }
  public static var secondaryWritableKey: WritableKeyPath<Self, Int> { \.row }
}

extension GridDimensions: AxisKeyPathWritable {
  public static var primaryWritableKey: WritableKeyPath<Self, Int> { \.width }
  public static var secondaryWritableKey: WritableKeyPath<Self, Int> { \.height }
}
