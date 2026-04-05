//
//  GridDimensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

import Foundation

public struct GridDimensions: Sendable, Codable, Equatable, Hashable {
  public var width: Int
  public var height: Int

  public var columns: Int { width }
  public var rows: Int { height }

  public init(width: Int, height: Int) {
//    precondition(width > 0 && height > 0, "GridDimensions cannot have zero or negative dimensions.")
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

extension GridDimensions: CustomStringConvertible {
  public var description: String { "\(width) x \(height)" }
}

//import SwiftUI


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
