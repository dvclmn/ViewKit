//
//  Dimensions+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

// MARK: - Multiplication

// GridDimensions × GridDimensions
public func * (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width * rhs.width,
    height: lhs.height * rhs.height
  )
}

// GridDimensions × Int
public func * (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width * rhs,
    height: lhs.height * rhs
  )
}

// CGSize × GridDimensions
public func * (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width * CGFloat(rhs.width)
  let h = lhs.height * CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

// MARK: - Addition

// GridDimensions + GridDimensions
public func + (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width + rhs.width,
    height: lhs.height + rhs.height
  )
}

// GridDimensions + Int
public func + (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width + rhs,
    height: lhs.height + rhs
  )
}

// CGSize + GridDimensions
public func + (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width + CGFloat(rhs.width)
  let h = lhs.height + CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}

// MARK: - Subtraction

// GridDimensions - GridDimensions
public func - (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width - rhs.width,
    height: lhs.height - rhs.height
  )
}

// GridDimensions - Int
public func - (lhs: GridDimensions, rhs: Int) -> GridDimensions {
  return GridDimensions(
    width: lhs.width - rhs,
    height: lhs.height - rhs
  )
}

// CGSize - GridDimensions
public func - (lhs: CGSize, rhs: GridDimensions) -> CGSize {
  let w = lhs.width - CGFloat(rhs.width)
  let h = lhs.height - CGFloat(rhs.height)
  return CGSize(width: w, height: h)
}
