//
//  Grid+Joining.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {
  public func joinedHorizontally(
    with other: Self,
//    padding cell: Cell? = nil
  ) -> Self {
    
    let maxHeight = Swift.max(self.height, other.height)
    
    var result = Self([])

    for i in 0..<maxHeight {
      let lhs = self[row: i]
      let rhs = other[row: i]
      
      result.append(lhs + rhs)
    }
    return result
  }
}
