//
//  GridConfiguration.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

//import BasePrimitives
//import SwiftUI

//public struct GridLineConfiguration {
//  let fillStyle: GridFillStyle
//  let cellSize: CGSize
//  let colour: Color
//  let strokeThickness: CGFloat
//
//  public init(
//    fillSize: CGSize,
//    cellSize: CGSize,
//    colour: Color = .gray.opacity(0.4),
//    strokeThickness: CGFloat = 1.0,
//  ) {
//    self.fillStyle = .fill(size: fillSize)
//
//    self.cellSize = cellSize
//    self.colour = colour
//    self.strokeThickness = strokeThickness
//  }
//
//  public init(
//    columnCount: Int,
//    rowCount: Int,
//    cellSize: CGSize,
//    colour: Color = .gray.opacity(0.4),
//    strokeThickness: CGFloat = 1.0,
//  ) {
//    self.fillStyle = .fixed(columns: columnCount, rows: rowCount)
//    self.cellSize = cellSize
//    self.colour = colour
//    self.strokeThickness = strokeThickness
//  }
//}
//
//extension GridLineConfiguration {
//  
//  public var gridSize: UnitSize? {
//    let unitSize = self.cellSize
//
//    return switch fillStyle {
//      case .fixed(let columns, let rows):
//        UnitSize(width: columns, height: rows, unitSize: unitSize)
//
//      case .fill(let size):
//        UnitSize(fromSize: size, unitSize: unitSize)
//    }
//  }
//}
