//
//  SafeIndexAccess.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/12/2025.
//

import Foundation

extension MutableCollection {

  public subscript(safe index: Index) -> Element? {
    get { indices.contains(index) ? self[index] : nil }
    set {
      guard let newValue, indices.contains(index) else { return }
      self[index] = newValue
    }
  }
}

extension Collection {
//extension Collection where Element == String {

  //  public subscript(safe index: Index) -> Element? {
  //    indices.contains(index) ? self[index] : nil
  //  }

  public subscript(safe bounds: Range<Index>) -> SubSequence? {
    guard
      bounds.lowerBound >= startIndex,
      bounds.upperBound <= endIndex
    else {
      return nil
    }

    return self[bounds]
  }

  public subscript(safe bounds: ClosedRange<Index>) -> SubSequence? {
    guard
      bounds.lowerBound >= startIndex,
      bounds.upperBound < endIndex
    else {
      return nil
    }

    return self[bounds]
  }

  public func hasIndex(_ offset: Int) -> Bool {
    let startIndex = self.startIndex
    let endIndex = self.endIndex
    guard let index = self.index(startIndex, offsetBy: offset, limitedBy: endIndex) else {
      return false
    }
    return index < endIndex
  }

}
