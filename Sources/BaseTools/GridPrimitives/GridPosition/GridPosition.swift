//
//  GridPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

/// This is like `CGPoint`
///
/// 📣 Important: ASCII-based / original GridPosition emphatically did
/// not allow negative values. Will need to evaluate impact of one
/// approach or the other, and be careful about refactoring.
///
/// ```
/// precondition(
///   row >= 0 && column >= 0,
///   "GridPosition cannot be negative, in either dimension."
/// )
/// ```
public struct GridPosition: Sendable, Codable, Equatable, Hashable {
  public var column: Int  // x
  public var row: Int  // y

  public init(column: Int, row: Int) {
    self.column = column
    self.row = row
  }

  public init(_ column: Int, _ row: Int) {
    self.column = column
    self.row = row
  }

  public init(x: Int, y: Int) { self.init(column: x, row: y) }
}

extension GridPosition {

  /// Cartesian X equivalent (Column)
  public var x: Int { column }

  /// Cartesian Y equivalent (Row)
  public var y: Int { row }

}

extension GridPosition: CustomStringConvertible {
  public var description: String { "R\(row) C\(column)" }
}
