//
//  Grid+Joining.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

extension GridShaped {
  
  public static func joined(
    _ others: Self...,
    along axis: Axis,
  ) -> Self {
    others.reduce(Self([])) { partial, grid in
      switch axis {
        case .horizontal:
          partial.joinedHorizontally(with: grid)
          
        case .vertical:
          partial.joinedVertically(with: grid)
      }
    }
  }
  
//  public static func joined(
//    _ stacks: [Self],
//    along axis: Axis,
//  ) -> Self {
//    
//    Self.joined(<#T##others: GridShaped...##GridShaped#>, along: <#T##Axis#>)
//    
//    return stacks.reduce(Self([])) { partial, stack in
//      Self.joined(partial, along: <#T##Axis#>)
////      StringStack.joined(partial, stack, along: axis, padding: padding)
//    }
//  }

  private func joinedVertically(with other: Self) -> Self {

    var result = self

    for row in other {
      result.append(row)
    }

    return result
  }

  private func joinedHorizontally(
    with other: Self
  ) -> Self {

    let maxHeight = Swift.max(self.height, other.height)

    var result = self

    for i in 0..<maxHeight {
      let lhs = self[row: i]
      let rhs = other[row: i]

      result.append(lhs + rhs)
    }
    return result
  }
}
