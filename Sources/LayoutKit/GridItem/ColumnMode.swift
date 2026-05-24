//
//  GridItem.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/6/2025.
//

import SwiftUI
import CoreTools
import ViewTools

extension ColumnConfig {

  public enum Mode: Sendable {
    
    case fixedColumns(Int, GridConfig.FitMode)
    case adaptive(GridConfig.FitMode)
    
    public static let `default`: Self = .adaptive(.fill(min: 60, max: 140))
  }
}

extension ColumnConfig.Mode {
  public func columns(
    spacing: CGFloat?,
    alignment: Alignment?
  ) -> [GridItem] {
    switch self {
      case .fixedColumns(let count, let mode):
        return [GridItem].columns(
          count,
          mode: mode,
          spacing: spacing,
          alignment: alignment
        )

      case .adaptive(let mode):
        return [GridItem].adaptive(
          mode: mode,
          spacing: spacing,
          alignment: alignment
        )
    }
  }
}

extension ColumnConfig.Mode: CustomStringConvertible {
  public var description: String {
    return DisplayString {
      switch self {
        case .fixedColumns(let count, let fitMode): "Fixed Columns [count: \(count), mode: \(fitMode)]"
        case .adaptive(let fitMode): "Adaptive [mode: \(fitMode)]"
      }
    }.text
  }
}
