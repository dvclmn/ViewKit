//
//  Collection.swift
//  Collection
//
//  Created by Dave Coleman on 17/12/2024.
//

extension MutableCollection {
  public subscript(safe index: Index) -> Element? {
    get {
      indices.contains(index) ? self[index] : nil
    }
    set {
      guard let newValue, indices.contains(index) else { return }
      self[index] = newValue
    }
  }
}

extension Collection {

  public subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }

  public func hasIndex(_ offset: Int) -> Bool {
    let startIndex = self.startIndex
    let endIndex = self.endIndex
    guard let index = self.index(startIndex, offsetBy: offset, limitedBy: endIndex) else {
      return false
    }
    return index < endIndex
  }

  public var toArray: [Element] {
    return Array(self)
  }
}

extension Collection where Index == Int {

  /// Core index calculation logic - reusable across different collection types
  public func nextIndex(
    after index: Int,
    wrapping: Bool = true
  ) -> Int? {
    let nextIdx = index + 1
    guard wrapping else {
      return nextIdx < count ? nextIdx : nil
    }
    return nextIdx % count
  }

  public func previousIndex(
    before index: Int,
    wrapping: Bool = true
  ) -> Int? {
    let prevIdx = index - 1
    guard wrapping else {
      return prevIdx >= 0 ? prevIdx : nil
    }
    return (prevIdx + count) % count
  }
}

extension Collection where Element: Hashable {
  /// Was called something like `isAtTop`
  //  public func isOnlyFirstElementSelected(
  //    currentSelection: Element.ID?
  //  ) -> Bool {
  //    if let currentSelection {
  //      return self.isOnlyFirstElementSelected(currentSelection: [currentSelection])
  //    }
  //    return false
  //  }

  public func isOnlyFirstElementSelected(
    for selection: Set<Element>
  ) -> Bool {
    guard let firstResultID = self.first else {
      return false
    }

    /// I only want a *single* result selected, and to know
    /// if it's at the top/start of the list
    guard selection.count == 1,
      let firstSelected = selection.first
    else { return false }
    return firstResultID == firstSelected
  }
}

// TODO: These extensions were way too broad, so were popping up in every auto-complete.
//extension Set {
//  //extension Set where Element: Identifiable, Element.ID: Hashable {
//  public func isAtTop<T: Collection>(of collection: T) -> Bool where T.Element == Self.Element {
//
//    guard let firstResultID = collection.first else {
//      return false
//    }
//
//    /// I only want a *single* result selected, and to know
//    /// if it's at the top/start of the list
//    guard self.count == 1,
//      let firstSelected = self.first
//    else { return false }
//    return firstResultID == firstSelected
//
//    //    return collection.isOnlyFirstElementSelected(for: [self])
//  }
//}
//
//extension Hashable {
//  //extension Set where Element: Identifiable, Element.ID: Hashable {
//  public func isAtTop<T: Collection>(of collection: T) -> Bool where T.Element == Self {
//    guard let firstResult = collection.first else {
//      return false
//    }
//    return firstResult == self
//  }
//
//  //extension Set where Element: Identifiable, Element.ID: Hashable {
//  public func isAtTop<T: Collection>(of collection: T) -> Bool
//  where T.Element: Hashable, T.Element: Identifiable, T.Element.ID == Self {
//    guard let firstResultID = collection.first?.id else {
//      return false
//    }
//    return firstResultID == self
//  }
//}
