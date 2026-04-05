//
//  Collection+Conformance.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

extension IdentifiedList: RandomAccessCollection, MutableCollection {
  public typealias Index = Int
  
  @inlinable public var startIndex: Int { elements.startIndex }
  @inlinable public var endIndex: Int { elements.endIndex }
  @inlinable public func index(after i: Int) -> Int { elements.index(after: i) }
  @inlinable public func index(before i: Int) -> Int { elements.index(before: i) }
  
  @inlinable public subscript(position: Int) -> Element {
    get { elements[position] }
    set {
      let old = elements[position]
      elements[position] = newValue
      if old.id != newValue.id {
        indexByID.removeValue(forKey: old.id)
        indexByID[newValue.id] = position
      } else {
        indexByID[newValue.id] = position
      }
    }
  }
}
