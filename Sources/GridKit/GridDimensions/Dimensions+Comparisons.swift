//
//  Dimensions+Comparisons.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

extension GridDimensions {
  
  // MARK: - Greater than
  public func bothGreaterThan(rhs: GridDimensions) -> Bool {
    self.rows > rhs.rows && self.columns > rhs.columns
  }
  public func bothGreaterThan(rhs: Int) -> Bool {
    self.rows > rhs && self.columns > rhs
  }
  
  // MARK: - Less than
  public func bothLessThan(rhs: GridDimensions) -> Bool {
    self.rows < rhs.rows && self.columns < rhs.columns
  }
  public func bothLessThan(rhs: Int) -> Bool {
    self.rows < rhs && self.columns < rhs
  }
}
