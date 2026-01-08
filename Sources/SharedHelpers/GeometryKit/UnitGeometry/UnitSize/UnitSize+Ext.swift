//
//  UnitSize+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import CoreGraphics
import Foundation

//import SharedHelpers
//public typealias UnitSizeCounts = (width: Int, height: Int)

extension UnitSize {

  public var intWidth: Int { width.gridLength }
  public var intHeight: Int { height.gridLength }

  public var screenWidth: CGFloat { width.screenLength() }
  public var screenHeight: CGFloat { height.screenLength() }

  public var screenSize: CGSize? {
    guard let lengthW = width.screenLength, let lengthH = height.screenLength else {
      return nil
    }
    return CGSize(width: lengthW, height: lengthH)
  }

  public func screenSize(fallback: CGSize = CGSize.zero) -> CGSize {
    screenSize ?? fallback
  }

  public func adjustCounts(
    transform: (Int, Int) -> (width: Int, height: Int)
  ) -> UnitSize? {
    let transformed = transform(width.gridLength, height.gridLength)
    return UnitSize(
      width: transformed.width,
      height: transformed.height,
      unitSize: unitSize
    )
  }

  private var unitSize: CGSize {
    return CGSize(
      width: width.unitLength,
      height: height.unitLength
    )
  }
}

//public func * (lhs: CGSize, rhs: UnitSize) -> CGSize {
//  let w = lhs.width * CGFloat(rhs.width)
//  let h = lhs.height * CGFloat(rhs.height)
//  return CGSize(width: w, height: h)
//}

/// Adds
//public func + (lhs: CGSize, rhs: UnitSize) -> CGSize {
//  let w = lhs.width + CGFloat(rhs.width)
//  let h = lhs.height + CGFloat(rhs.height)
//  return CGSize(width: w, height: h)
//}
//
//public func - (lhs: CGSize, rhs: UnitSize) -> CGSize {
//  let w = lhs.width - CGFloat(rhs.width)
//  let h = lhs.height - CGFloat(rhs.height)
//  return CGSize(width: w, height: h)
//}

extension UnitSize: CustomStringConvertible {
  public var description: String {
    //    let scrWidth: String = screenWidth.formatted()
    return "W: \(screenWidth) (\(width))\nH: \(screenHeight) (\(height))"
  }
}
