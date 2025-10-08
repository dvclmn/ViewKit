//
//  Model+ListNavigator.swift
//  BaseComponents
//
//  Created by Dave Coleman on 26/5/2025.
//

//import Foundation


#warning("Perhaps this is useful. But have turned off for now, as not using, and has compiler errors.")

//struct ListNavigator<Item: Identifiable> {
//  let items: [Item]
//  var currentIndex: Int?
//  
//  func nextIndex(wrapping: Bool = true) -> Int? {
//    CyclicIndex.next(current: currentIndex, count: items.count, wrapping: wrapping)
//  }
//  
//  func previousIndex(wrapping: Bool = true) -> Int? {
//    CyclicIndex.previous(current: currentIndex, count: items.count, wrapping: wrapping)
//  }
//  
//  func id(at index: Int?) -> Item.ID? {
//    guard let i = index, items.indices.contains(i) else { return nil }
//    return items[i].id
//  }
//  
//  func index(for id: Item.ID?) -> Int? {
//    guard let id else { return nil }
//    return items.firstIndex { $0.id == id }
//  }
//}

