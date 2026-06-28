//
//  Data.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/10/2025.
//

import Foundation


//public protocol Editable: Sendable, Codable, Equatable, Hashable {
//  var dateAdded: Date { get }
//  var dateDeleted: Date? { get set }
//  var dateModified: Date? { get set }
//}


public protocol DataStore {
  associatedtype Item: Sendable, Codable, Equatable, Hashable & Identifiable
  associatedtype Config: ItemConfiguration
  var items: [Item] { get set }
//  var items: IdentifiedArrayOf<Item> { get set }
  var selectedItems: Set<Item.ID> { get set }
  var configs: [Item.ID: Config] { get set }
  
  /// Available only when single selection
  var selected: Item? { get }
}

public protocol ItemConfiguration: Identifiable {
  associatedtype Item: Sendable, Codable, Equatable, Hashable & Identifiable
  var id: UUID { get }
  var itemID: Item.ID { get }
}
