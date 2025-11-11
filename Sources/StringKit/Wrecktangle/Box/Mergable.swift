//
//  Mergable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

protocol Mergable {
  associatedtype MapKey: Hashable
  associatedtype Value
  typealias Map = [MapKey: Value]
  
  var map: Map { get set }
  func merged(with other: Self) -> Self
}


extension Mergable {
  func merged(with other: Self) -> Self {
    var new = self
    for (key, value) in other.map {
      new.map[key] = value
    }
    return new
  }
}
