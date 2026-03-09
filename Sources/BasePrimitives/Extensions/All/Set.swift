//
//  Set.swift
//  Collection
//
//  Created by Dave Coleman on 26/9/2024.
//

import Foundation

extension Set {
  public var toArray: [Element] {
    Array(self)
  }
}

public enum SelectionPosition {
  case single
  case top
  case middle
  case bottom
}

extension Set {
  public func selectionPosition<T: Hashable>(
    for id: Element,
    idForElement: (T) -> Element,
    in sortedElements: [T],
    isPreviousSelected: (Element) -> Bool,
    isNextSelected: (Element) -> Bool
  ) -> SelectionPosition? {
    guard self.contains(id) else { return nil }

    guard let index = sortedElements.firstIndex(where: { idForElement($0) == id }) else {
      return .single
    }

    let previousSelected = index > 0 ? isPreviousSelected(idForElement(sortedElements[index - 1])) : false
    let nextSelected =
      index < sortedElements.count - 1 ? isNextSelected(idForElement(sortedElements[index + 1])) : false

    switch (previousSelected, nextSelected) {
      case (false, false): return .single
      case (true, false): return .bottom
      case (false, true): return .top
      case (true, true): return .middle
    }
  }
}
extension Set {
  /// Toggles membership of `element` in the set.
  /// - Returns: `true` if the element is a member after the toggle, `false` if it was removed.
  @discardableResult
  public mutating func toggleMembership(of element: Element) -> Bool {
    guard self.contains(element) else {
      self.insert(element)
      return true
    }
    self.remove(element)
    return false
  }

  /// Sets membership of `element` in the set to match `isMember`.
  /// - Parameters:
  ///   - element: The element whose membership to update.
  ///   - isMember: When `true`, the element will be present in the set; when `false`, it will be removed.
  /// - Returns: `true` if the element is a member after the update, `false` otherwise.
  @discardableResult
  public mutating func setMembership(of element: Element, to isMember: Bool) -> Bool {
    if isMember {
      self.insert(element)
      return true
    } else {
      self.remove(element)
      return false
    }
  }
}
