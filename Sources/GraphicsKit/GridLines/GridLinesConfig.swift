//
//  GridLinesConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

//public struct GridConfiguration {
//  public let gridMode: GridSizeMode
//  public let colour: Color
//  public let lineWidth: CGFloat
//  public let density: GridAnnotationDensity
//
//  public init(
//    fillStyle: GridSizeMode,
//    colour: Color,
//    lineWidth: CGFloat,
//    density: GridAnnotationDensity
//  ) {
//    self.gridMode = fillStyle
//    self.colour = colour
//    self.lineWidth = lineWidth
//    self.density = density
//  }
//}

//extension GridConfiguration {

//  public var shouldDrawLines: Bool {
//    density.isShowingCellMarkers
//  }

//}

public enum GridAnnotationDensity: Int {
  case full = 1
  case threeQuarters = 2
  case half = 4
  case quarter = 8
  case none = 0

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

}

extension GridAnnotationDensity {
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

  var isShowingCellMarkers: Bool {
    if self == .none || self == .quarter { return false }
    return true
  }
}
