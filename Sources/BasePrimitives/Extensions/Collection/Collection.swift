//
//  Collection.swift
//  Collection
//
//  Created by Dave Coleman on 17/12/2024.
//

extension Collection {
  public var toArray: [Element] {
    return Array(self)
  }
}

extension BidirectionalCollection {
  public func nextIndex(
    after index: Index,
    wrapping: Bool = true
  ) -> Index? {
    guard !isEmpty else { return nil }
    
    let next = self.index(after: index)
    if next != endIndex {
      return next
    } else {
      return wrapping ? startIndex : nil
    }
  }
  
  public func previousIndex(
    before index: Index,
    wrapping: Bool = true
  ) -> Index? {
    guard !isEmpty else { return nil }
    
    if index != startIndex {
      return self.index(before: index)
    } else {
      return wrapping ? self.index(before: endIndex) : nil
    }
  }
}

extension BidirectionalCollection where Element: Equatable {
  public func nextElement(
    after element: Element,
    wrapping: Bool = true
  ) -> Element? {
    guard
      let i = firstIndex(of: element),
      let next = nextIndex(after: i, wrapping: wrapping)
    else { return nil }
    
    return self[next]
  }
  
  public func previousElement(
    before element: Element,
    wrapping: Bool = true
  ) -> Element? {
    guard
      let i = firstIndex(of: element),
      let prev = previousIndex(before: i, wrapping: wrapping)
    else { return nil }
    
    return self[prev]
  }
}


//extension Collection where Index == Int {
//  public func nextIndex(after index: Int, wrapping: Bool = true) -> Int? {
//    /// Handle empty collection to prevent division by zero
//    guard count > 0 else { return nil }
//    
//    let nextIdx = index + 1
//    if nextIdx < count {
//      return nextIdx
//    } else {
//      return wrapping ? 0 : nil
//    }
//  }
//  
//  public func previousIndex(before index: Int, wrapping: Bool = true) -> Int? {
//    guard count > 0 else { return nil }
//    
//    let prevIdx = index - 1
//    if prevIdx >= 0 {
//      return prevIdx
//    } else {
//      /// Standard way to wrap negative indices: (index - 1 + count) % count
//      return wrapping ? count - 1 : nil
//    }
//  }
  
//  public func nextIndex(
//    after index: Int,
//    wrapping: Bool = true
//  ) -> Int? {
//    let nextIdx = index + 1
//    guard wrapping else {
//      return nextIdx < count ? nextIdx : nil
//    }
//    return nextIdx % count
//  }
//
//  public func previousIndex(
//    before index: Int,
//    wrapping: Bool = true
//  ) -> Int? {
//    let prevIdx = index - 1
//    guard wrapping else {
//      return prevIdx >= 0 ? prevIdx : nil
//    }
//    return (prevIdx + count) % count
//  }
//}

extension Collection where Element: Hashable {
  /// Was called something like `isAtTop`
  public func isOnlyFirstSelected(
    in selection: Set<Element>
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

  public func isOnlyElementSelected(
    _ element: Element,
    in selection: Set<Element>
  ) -> Bool {
    selection.count == 1 && selection.first == element
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

extension Array where Element: Collection, Element.Element: CustomStringConvertible {

  @available(*, deprecated, message: "Prefer protocol `PrettyPrinted`")
  public func indented(
    startingIndentation: Int = 0,
    indentString: String = "\t"
  ) -> String {
    self.map { row in
      /// single-level indentation for inner elements
      let prefix = String(repeating: indentString, count: startingIndentation)
      return row.map {
        """
        \(prefix)└─ \($0.description)
        """
        //        """
        //        \(prefix)[
        //        \(prefix)\(indentString)\($0.description)
        //        \(prefix)]
        //        """
      }
      .joined(separator: "\n")
    }
    .joined(separator: "\n")
  }
}

//extension Collection {
//
//  func indented<T: CustomStringConvertible>(_ array: [T], level: Int = 0) -> String {
//    array.map { element in
//      let prefix = String(repeating: "  ", count: level)
//      if let subArray = element as? [Any] {
//        return indented(subArray, level: level + 1)
//      } else if let value = element as? T {
//        return prefix + "\(value)"
//      } else {
//        return prefix + "\(element)"
//      }
//    }.joined(separator: "\n")
//  }
/// Recursively returns an indented string representation of this collection.
//  public func indented(indentLevel: Int = 0, indentString: String = "  ") -> String {
//    let prefix = String(repeating: indentString, count: indentLevel)
//
//    return self.map { element -> String in
//      if let subCollection = element as? any Collection {
//        // Recurse into sub-collections
//        return (subCollection).indented(indentLevel: indentLevel + 1, indentString: indentString)
//      } else if let describable = element as? CustomStringConvertible {
//        // Leaf node
//        return prefix + describable.description
//      } else {
//        // Fallback for any type
//        return prefix + "\(element)"
//      }
//    }
//    .joined(separator: "--\n")
//  }
//}
