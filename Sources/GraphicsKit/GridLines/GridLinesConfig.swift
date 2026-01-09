//
//  GridLinesConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct GridConfiguration {
  let cellSize: CGSize
  let color: Color
  let lineWidth: CGFloat
  let pan: CGPoint
  let density: DisplayDensity
  
  // Determine if we should even draw based on the second implementation's logic
  var shouldDrawLines: Bool {
    density.isShowingCellMarkers
  }
}

enum DisplayDensity: Int {
  case full = 1
  case threeQuarters = 2
  case half = 4
  case quarter = 8
  case none = 0
  
  var stepSize: Int? {
    guard self != .none else { return nil }
    return rawValue
  }
  
  var name: String {
    switch self {
      case .full: "All"
      case .threeQuarters: "Three quarters"
      case .half: "Half"
      case .quarter: "Quarter"
      case .none: "None"
    }
  }
  
  init(zoomPercent: CGFloat, adjustmentFactor: CGFloat) {
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
