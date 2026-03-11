//
//  IdentifiedList.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

///  A lightweight, dependency-free alternative to IdentifiedCollections' IdentifiedArray.
///  Stores elements in an Array for stable ordering and a Dictionary for O(1) id-based lookups.
///  This is intentionally minimal: it implements just what we need today, and can be extended
///  in place as requirements grow.

import Foundation

/// A list of identifiable elements with O(1) lookup and mutation by id,
/// backed by standard library `Array` and `Dictionary`.
public struct IdentifiedList<Element: Identifiable> {
  // MARK: - Storage
  @usableFromInline
  internal var elements: [Element]

  @usableFromInline
  internal var indexByID: [Element.ID: Int]

  // MARK: - Initializers

  /// Creates an empty identified list.
  @inlinable
  public init() {
    self.elements = []
    self.indexByID = [:]
  }

  /// Creates an identified list from an array of elements.
  /// If duplicate ids are encountered, the last occurrence wins.
  @inlinable
  public init(_ elements: [Element]) {
    self.elements = []
    self.indexByID = [:]
    reserveCapacity(elements.count)
    for element in elements { append(element) }
  }
}

extension IdentifiedList: Equatable where Element: Equatable {}
extension IdentifiedList: Sendable where Element: Sendable, Element.ID: Sendable {}

extension IdentifiedList {

  // MARK: - Capacity
  @inlinable
  public mutating func reserveCapacity(_ n: Int) {
    elements.reserveCapacity(n)
    indexByID.reserveCapacity(n)
  }

  // MARK: - Basic operations

  /// Appends an element. If an element with the same id already exists, it is replaced in-place.
  @inlinable
  public mutating func append(_ element: Element) {
    let id = element.id
    if let idx = indexByID[id] {
      elements[idx] = element
    } else {
      elements.append(element)
      indexByID[id] = elements.endIndex - 1
    }
  }

  /// Removes the element at the given index.
  @discardableResult
  @inlinable
  public mutating func remove(at index: Int) -> Element {
    precondition(elements.indices.contains(index), "Index out of bounds")
    let removed = elements.remove(at: index)
    // Rebuild affected indices after removal.
    indexByID.removeValue(forKey: removed.id)
    // Only indices after `index` shift; adjust them.
    for i in index..<elements.endIndex {
      indexByID[elements[i].id] = i
    }
    return removed
  }

  /// Removes the element with the given id, if present.
  @discardableResult
  @inlinable
  public mutating func remove(id: Element.ID) -> Element? {
    guard let idx = indexByID[id] else { return nil }
    return remove(at: idx)
  }

  // MARK: - Id-based subscript

  /// Accesses the element associated with the given id for reading and writing.
  /// - If setting to `nil`, removes the element if it exists.
  /// - If setting a non-nil value:
  ///   - Replaces in-place if the id exists.
  ///   - Appends if the id does not exist.
  @inlinable
  public subscript(id id: Element.ID) -> Element? {
    get {
      guard let idx = indexByID[id] else { return nil }
      return elements[idx]
    }
    set {
      if let newValue = newValue {
        let newID = newValue.id
        if let idx = indexByID[id] {
          // Replace at the existing index. If ids differ, update map.
          elements[idx] = newValue
          if newID != id {
            indexByID.removeValue(forKey: id)
            indexByID[newID] = idx
          }
        } else {
          // Not present: append.
          elements.append(newValue)
          indexByID[newID] = elements.endIndex - 1
        }
      } else {
        // Set to nil: remove if present.
        _ = remove(id: id)
      }
    }
  }
}

// MARK: - Collection conformance

// MARK: - Codable
