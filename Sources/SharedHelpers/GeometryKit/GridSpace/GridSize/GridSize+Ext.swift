//
//  GridSize+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

//import SharedHelpers
//public typealias GridSizeCounts = (width: Int, height: Int)

extension GridSize {

  public var zero: GridSize { GridSize(columns: <#T##GridLength#>, rows: <#T##GridLength#>) }
  public var width: Int { columns.gridLength }
  public var height: Int { rows.gridLength }

  public var screenWidth: CGFloat { columns.screenLength }
  public var screenHeight: CGFloat { rows.screenLength }

  public var screenSize: CGSize {
    CGSize(width: columns.screenLength, height: rows.screenLength)
  }

  public func adjustCounts(
    transform: (Int, Int) -> (width: Int, height: Int)
  ) -> GridSize? {
    let transformed = transform(columns.gridLength, rows.gridLength)
    return GridSize(
      width: transformed.width,
      height: transformed.height,
      unitSize: unitSize
    )
  }

  private var unitSize: CGSize {
    return CGSize(
      width: columns.unitLength,
      height: rows.unitLength
    )
  }
}

public func * (lhs: CGSize, rhs: GridSize) -> CGSize {
  let w = lhs.width * CGFloat(rhs.width)
  let h = lhs.height * CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

/// Adds
public func + (lhs: CGSize, rhs: GridSize) -> CGSize {
  let w = lhs.width + CGFloat(rhs.width)
  let h = lhs.height + CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

public func - (lhs: CGSize, rhs: GridSize) -> CGSize {
  let w = lhs.width - CGFloat(rhs.width)
  let h = lhs.height - CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

extension GridSize: CustomStringConvertible {
  public var description: String {
    //    let scrWidth: String = screenWidth.formatted()
    return "W: \(screenWidth) (\(width))\nH: \(screenHeight) (\(height))"
  }
}
