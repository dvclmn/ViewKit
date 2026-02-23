//
//  DataOperation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/10/2025.
//

import Foundation

/// Assumes a basic structure of
///
/// ```
/// AppHandler
///   DataStruct
///     var data: [Item]
///     var selected: Set<Item.ID>
///
/// ```
enum DataOperation<T: DataStore> {
  /// No need to supply a specific ID for `selected`, the whole benefit
  /// here is I can get the ID(s) from the `selected` property.
  /// It's intended as a nice easy option.
  case selected
  
  /// When right-clicking an item in a SwiftUI List,
  /// this is the item that recieved the click. If an existing selection
  /// contains the right-clicked item, that whole selection is returned.
  /// Otherwise, just the right-clicked item is returned.
  case rightClicked(T.Item.ID)
  case single(T.Item.ID)
  case multiple([T.Item.ID])
  
  /// Note: This will return an empty Set for `selected`,
  /// if no selected Item is found.
  func idsForOperation(_ store: T) -> Set<T.Item.ID> {
    switch self {
      case .selected:
        guard let id = store.selected?.id else { return [] }
        return [id]
        
      case .rightClicked(let clicked):
        guard store.selectedItems.contains(clicked) else {
          return [clicked]
        }
        return store.selectedItems
        
      case .single(let id): return [id]
      case .multiple(let ids): return Set(ids)
    }
  }
  func count(_ store: T) -> Int {
    return self.idsForOperation(store).count
  }
}
