//
//  GridSize+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

public typealias GridSizeCounts = (width: Int, height: Int)

extension GridSize {
  
  public var width: Int { columns.count }
  public var height: Int { rows.count }
  
  public var screenWidth: CGFloat { columns.screenLength }
  public var screenHeight: CGFloat { rows.screenLength }
  
  public var gridSizeCounts: GridSizeCounts { (width, height) }
  
  public var screenSize: CGSize {
    CGSize(width: columns.screenLength, height: rows.screenLength)
  }
  
  public func adjustCounts(
    transform: (Int, Int) -> (width: Int, height: Int)
  ) -> GridSize? {
    let transformed = transform(columns.count, rows.count)
    return GridSize(
      width: transformed.width,
      height: transformed.height,
      unitSize: unitSize
    )
  }
  
  private var unitSize: CGSize {
    return CGSize(
      width: columns.unit,
      height: rows.unit
    )
  }
}


extension GridSize: CustomStringConvertible {
  public var description: String {
    return "W: \(screenWidth) (\(width))\nH: \(screenHeight) (\(height))"
  }
}

//extension CGSize {
//  public func gridSizeCounts() -> GridSizeCounts {
//    let gridSize = self.
//  }
//}
