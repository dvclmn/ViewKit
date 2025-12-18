//
//  Dimensions+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

public func * (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width * CGFloat(rhs.width)
  let h = lhs.height * CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

public func + (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width + CGFloat(rhs.width)
  let h = lhs.height + CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

public func - (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width - CGFloat(rhs.width)
  let h = lhs.height - CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}
