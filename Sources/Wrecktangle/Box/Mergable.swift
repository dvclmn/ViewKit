//
//  Mergable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

import SharedHelpers

//protocol Mergable {
//  associatedtype MapKey: Hashable
//  associatedtype Value
//  typealias Map = [MapKey: Value]
//
//  var map: Map { get set }
//  func merged(with other: Self) -> Self
//}
//
//extension Mergable {
//  func merged(with other: Self) -> Self {
//    map.toDictionary(key: <#T##KeyPath<(key: Hashable, value: Self.Value), Hashable>#>, value: <#T##KeyPath<(key: Hashable, value: Self.Value), Value>#>, keeping: <#T##MergeStrategy<Hashable, Value>#>)
//    
////    var new = self
////    for (key, value) in other.map {
////      new.map[key] = value
////    }
////    return new
//  }
//}
