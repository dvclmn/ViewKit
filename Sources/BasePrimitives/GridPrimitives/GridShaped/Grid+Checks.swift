//
//  Grid+Checks.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/3/2026.
//

extension GridShaped {
  
  /// True only if all rows have the same length
  public var isRectangular: Bool {
    guard let first = rows.first?.count else { return true }
    return rows.allSatisfy { $0.count == first }
  }

}
