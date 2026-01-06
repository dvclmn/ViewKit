//
//  GridDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation
import CoreTools

public struct GridDimensions: ModelBase {
  public let width: Int
  public let height: Int

  public init(width: Int, height: Int) {
    precondition(width > 0 && height > 0, "GridDimensions cannot have zero or negative dimensions.")
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

//import SwiftUI
//import SharedHelpers

//public struct GridDimensions: ModelBase {
//  public var columns: Int
//  public var rows: Int
//
//
//
//}

//extension GridDimensions: CustomStringConvertible {
//  public var description: String {
//    "Columns: \(columns) Rows: \(rows)"
//  }
//}

//extension CGSize {
//  public init(fromGridDimensions dimensions: GridDimensions) {
//
//  }
//}
