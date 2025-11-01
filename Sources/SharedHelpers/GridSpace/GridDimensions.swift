//
//  GridDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

public struct GridDimensions: Sendable, Equatable, Hashable {
  public let width: Int
  public let height: Int
  
  public init(width: Int, height: Int) {
    self.width = width
    self.height = height
  }
  public init(_ width: Int, _ height: Int) {
    self.init(width: width, height: height)
  }
}

extension GridDimensions: ExpressibleByIntegerLiteral {
  /// Creates an instance with the provided value for both dimensions
  public init(integerLiteral value: Int) {
    self.init(width: value, height: value)
  }
}

extension GridDimensions {
  public var doubled: GridDimensions {
    GridDimensions(width: width * 2, height: height * 2)
  }
}

public func + (lhs: GridDimensions, rhs: GridDimensions) -> GridDimensions {
  return GridDimensions(
    width: lhs.width + rhs.width,
    height: lhs.height + rhs.height
  )
}
