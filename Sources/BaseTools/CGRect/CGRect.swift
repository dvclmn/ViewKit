//
//  CGRect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/6/2026.
//

import Foundation

extension CGRect {
  public init(x: Float, y: Float, width: Float, height: Float) {
    self.init(
      x: Double(x),
      y: Double(y),
      width: Double(width),
      height: Double(height)
    )
  }
  
  public init?<T: BinaryFloatingPoint>(fromArray array: [T]) {
    guard let x = array[safe: 0],
          let y = array[safe: 1],
          let width = array[safe: 2],
          let height = array[safe: 3]
    else { return nil }
    self.init(
      x: CGFloat(x),
      y: CGFloat(y),
      width: CGFloat(width),
      height: CGFloat(height),
    )
  }
}
