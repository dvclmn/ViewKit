//
//  GridProjection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import Foundation

/// Suggestion from Gemini
/// Bridges the gap between pure Grid dimensions and Canvas (continuous) space.
/// Note: The only piece that needs to know about e.g.  ASCII cell size.
public struct GridProjection {
  
  /// The size of a single grid cell in Canvas Space.
  public let unitSize: CGSize // e.g., 10x18 for a font
  
  //  public var cellSize: CGSize
  public var rounding: GridRounding = .down
  
  public init(unitSize: CGSize) {
    self.unitSize = unitSize
  }
}

extension GridProjection {
  
  /// Converts Canvas space (continuous) to Grid space (discrete)
  public func gridPosition(from point: Point<CanvasSpace>) -> GridPosition {
    GridPosition(
      column: Int(floor(point.x / unitSize.width)),
      row: Int(floor(point.y / unitSize.height))
    )
  }

  // MARK: - Grid to Canvas (Up the chain)

//  public func canvasSize(for dimensions: GridDimensions) -> CGSize {
//    CGSize(
//      width: CGFloat(dimensions.width) * cellSize.width,
//      height: CGFloat(dimensions.height) * cellSize.height
//    )
//  }
//
//  public func canvasPoint(for position: GridPosition) -> CGPoint {
//    CGPoint(
//      x: CGFloat(position.x) * cellSize.width,
//      y: CGFloat(position.y) * cellSize.height
//    )
//  }
//
//  // MARK: - Canvas to Grid (Down the chain)
//
//  public func gridDimensions(for canvasSize: CGSize) -> GridDimensions {
//    // Here you would implement your specific rounding logic
//    GridDimensions(
//      width: Int(canvasSize.width / cellSize.width),  // Simplified
//      height: Int(canvasSize.height / cellSize.height)
//    )
//  }
//
//  public func gridPosition(for canvasPoint: CGPoint) -> GridPosition {
//    GridPosition(
//      x: Int(canvasPoint.x / cellSize.width),
//      y: Int(canvasPoint.y / cellSize.height)
//    )
//  }
}

/// Suggestion from Claude
//public struct GridGeometryContext {
//  public var unitSize: CGSize
//  public var dimensions: GridDimensions
//
//  public var screenSize: CGSize {
//    CGSize(
//      width: CGFloat(dimensions.columns) * unitSize.width,
//      height: CGFloat(dimensions.rows) * unitSize.height
//    )
//  }
//  //  public func gridPoint(from screenPoint: CGPoint) -> GridPoint? { ... }
//}

/// Suggestion from GPT
//struct GridMetrics: Hashable, Sendable {
//  /// Size of one cell in pixels
//  var cellSize: CGSize   // (or PixelSize if you want to go all-in)
//
//  /// Convert a cell-count to pixels
//  func pixels(from cells: CellCount) -> CGSize {
//    CGSize(
//      width: CGFloat(cells.columns) * cellSize.width,
//      height: CGFloat(cells.rows) * cellSize.height
//    )
//  }
//
//  /// Convert pixels to cell-count
//  func cells(from pixels: CGSize, rounding: GridRounding) -> CellCount? {
//    guard cellSize.width > 0, cellSize.height > 0 else { return nil }
//
//    func round(_ x: CGFloat) -> Int {
//      switch rounding {
//        case .down: return Int(floor(x))
//        case .up: return Int(ceil(x))
//        case .nearest: return Int((x).rounded())
//      }
//    }
//
//    return CellCount(
//      columns: round(pixels.width / cellSize.width),
//      rows: round(pixels.height / cellSize.height)
//    )
//  }
//}
