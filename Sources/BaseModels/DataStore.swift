//
//  Data.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/10/2025.
//

import Foundation
import IdentifiedCollections

public protocol ItemModel: Identifiable, Codable, Equatable, Hashable {}

public protocol DataStore {
  associatedtype Item: ItemModel
  associatedtype Config: ItemConfiguration
  var items: IdentifiedArrayOf<Item> { get set }
  var selectedItems: Set<Item.ID> { get set }
  var configs: [Item.ID: Config] { get set }
  
  /// Available only when single selection
  var selected: Item? { get }
}

public protocol ItemConfiguration: Identifiable {
  associatedtype Item: ItemModel
  var id: UUID { get }
  var itemID: Item.ID { get }
}
