//
//  Joining.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI

extension StringStack {



//  private func joinedHorizontally(
//    with other: Self,
//    padding char: Character? = nil
//  ) -> StringStack {
//
//    let maxHeight = Swift.max(self.height, other.height)
//
//    var result = StringStack([])
//
//    let lhsPadding = Self.createPadding(with: char, width: self.width)
//    let rhsPadding = Self.createPadding(with: char, width: other.width)
//
//    for i in 0..<maxHeight {
//      let lhs = self[row: i]
//      let rhs = other[row: i]
//
//      result.append(lhsPadding + lhs + rhs + rhsPadding)
//    }
//    return result
//  }
//
//  private func joinedVertically(
//    with other: Self,
//    padding: Character? = nil
//  ) -> Self {
//    
//    let maxWidth = Swift.max(self.width, other.width)
//    var result = self
//
//    for row in other {
//      if let padding {
//        let paddedRow = row + [Character](repeating: padding, count: maxWidth - row.count)
//        result.append(paddedRow)
//      } else {
//        result.append(row)
//      }
//    }
//    return result
//  }
//
//  static func createPadding(
//    with char: Character?,
//    width: Int,
//  ) -> [Character] {
//    guard let char else { return [] }
//    return Array(repeating: char, count: width)
//  }
}

/// Assumes horizontal joining
public func + (lhs: StringStack, rhs: StringStack) -> StringStack {
  StringStack.joined(lhs, rhs, along: .horizontal)
}

/// Joins horizontally
public func += (lhs: inout StringStack, rhs: StringStack) {
  lhs = lhs + rhs
}

