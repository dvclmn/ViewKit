//
//  Dimensions+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

public func * (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width * rhs.width,
    height: lhs.height * rhs.height
  )
}
public func + (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width + rhs.width,
    height: lhs.height + rhs.height
  )
}

public func - (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width - rhs.width,
    height: lhs.height - rhs.height
  )
}

// MARK: - Int
public func * (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width * rhs,
    height: lhs.height * rhs
  )
}
public func + (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width + rhs,
    height: lhs.height + rhs
  )
}

public func - (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width - rhs,
    height: lhs.height - rhs
  )
}

// MARK: - CGSize
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
