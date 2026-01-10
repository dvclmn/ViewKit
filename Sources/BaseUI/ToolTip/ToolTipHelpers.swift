//
//  ToolTipHelpers.swift
//  BaseComponents
//
//  Created by Dave Coleman on 1/10/2025.
//


import SwiftUI

extension Alignment {

  /// This remaps any alignments that don't quite make sense for
  /// a ToolTip, such as center (don't want it covering the content)
  var forTooltip: Alignment {
    switch self {
      case .center: .top
      default: self
    }
  }
  
  var toolTipUnitPoint: UnitPoint? {
    switch self {
      case .leading: return UnitPoint(x: 0, y: 0.5)
      case .trailing: return UnitPoint(x: 1, y: 0.5)
      case .top: return UnitPoint(x: 0.5, y: 0)
      case .bottom: return UnitPoint(x: 0.5, y: 1)
      case .topLeading: return .topLeading
      case .topTrailing: return .topTrailing
      case .bottomLeading: return .bottomLeading
      case .bottomTrailing: return .bottomTrailing
      case .center: return .center
      default: return nil // baseline cases
    }
  }
}
