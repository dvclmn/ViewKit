//
//  ModelBase.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import Foundation

@MainActor
public protocol ModelBase: Sendable, Codable, Equatable, Hashable {}

@MainActor
public protocol ModelBaseWithID: Sendable, Codable, Equatable, Hashable, Identifiable where ID: Hashable {
  var id: ID { get }
}

public protocol Editable: Sendable, Codable, Equatable, Hashable {
  var dateAdded: Date { get }
  var dateDeleted: Date? { get set }
  var dateModified: Date? { get set }
}
