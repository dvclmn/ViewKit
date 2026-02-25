//
//  GridLinesConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

public struct GridConfiguration {
  public let fillStyle: GridFillStyle
  public let cellSize: CGSize
  public let colour: Color
  public let lineWidth: CGFloat
  public let density: DisplayDensity

  public init(
    fillStyle: GridFillStyle,
    cellSize: CGSize,
    colour: Color,
    lineWidth: CGFloat,
    density: DisplayDensity
  ) {
    self.fillStyle = fillStyle
    self.cellSize = cellSize
    self.colour = colour
    self.lineWidth = lineWidth
    self.density = density
  }
}

extension GridConfiguration {
  /// Determine if we should even draw based on the second implementation's logic
  public var shouldDrawLines: Bool {
    density.isShowingCellMarkers
  }
  public var gridSize: UnitSize? {
    let unitSize = self.cellSize

    return switch fillStyle {
      case .fixed(let columns, let rows):
        UnitSize(width: columns, height: rows, unitSize: unitSize)

      case .fill(let size):
        UnitSize(fromSize: size, unitSize: unitSize)
    }
  }
}

public enum GridFillStyle {
  case fixed(columns: Int, rows: Int)
  case fill(size: CGSize)
}

public enum DisplayDensity: Int {
  case full = 1
  case threeQuarters = 2
  case half = 4
  case quarter = 8
  case none = 0

  public var stepSize: Int? {
    guard self != .none else { return nil }
    return rawValue
  }

  public var name: String {
    switch self {
      case .full: "All"
      case .threeQuarters: "Three quarters"
      case .half: "Half"
      case .quarter: "Quarter"
      case .none: "None"
    }
  }

  public init(zoomPercent: CGFloat, adjustmentFactor: CGFloat) {
    self = {
      switch zoomPercent {
        case ..<Double(0.1 * adjustmentFactor): return .none
        case ..<Double(0.3 * adjustmentFactor): return .quarter
        case ..<Double(0.7 * adjustmentFactor): return .half
        case ..<Double(0.9 * adjustmentFactor): return .threeQuarters
        default: return .full
      }
    }()
  }

  var isShowingCellMarkers: Bool {
    if self == .none || self == .quarter { return false }
    return true
  }
}
