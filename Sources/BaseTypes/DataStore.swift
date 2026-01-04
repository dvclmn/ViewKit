//
//  Data.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/10/2025.
//

import Foundation
import IdentifiedCollections
import CoreTools

public protocol DataStore {
  associatedtype Item: ModelBase & Identifiable
  associatedtype Config: ItemConfiguration
  var items: IdentifiedArrayOf<Item> { get set }
  var selectedItems: Set<Item.ID> { get set }
  var configs: [Item.ID: Config] { get set }
  
  /// Available only when single selection
  var selected: Item? { get }
}

public protocol ItemConfiguration: Identifiable {
  associatedtype Item: ModelBase & Identifiable
  var id: UUID { get }
  var itemID: Item.ID { get }
}
