//
//  Someting.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation

extension CountableClosedRange where Bound == Int {
  
  public func attributedRange(for attrString: AttributedString) -> Range<AttributedString.Index>? {
    let start = attrString.index(at: self.lowerBound)
    let end = attrString.index(at: self.upperBound + 1)

    guard let start, let end else { return nil }
    return start..<end
  }
}
