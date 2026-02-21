//
//  ArrayOperations.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

public enum ArrayOperation<Element> {
  case append(Element)
  case appendContents(contentsOf: [Element])
  case insert(Element, at: Int)
  case remove(at: Int)
  case removeAll(where: (Element) -> Bool)
  case set([Element])

  public func apply(to array: inout [Element]) {
    switch self {
      case .append(let element):
        array.append(element)

      case .appendContents(contentsOf: let elements):
        array.append(contentsOf: elements)

      case .insert(let element, let index):
        array.insert(element, at: index)

      case .remove(let index):
        guard array.indices.contains(index) else { return }
        array.remove(at: index)

      case .removeAll(let predicate):
        array.removeAll(where: predicate)

      case .set(let newValue):
        array = newValue
    }
  }
}

public enum SetOperation<Element: Hashable> {
  case insert(Element)
  case insertContents(contentsOf: Set<Element>)
  case remove(Element)
  case removeAll(where: (Element) -> Bool)
  case set(Set<Element>)

  public func apply(to set: inout Set<Element>) {
    switch self {
      case .insert(let element):
        set.insert(element)

      case .insertContents(contentsOf: let elements):
        set.formUnion(elements)

      case .remove(let element):
        set.remove(element)

      case .removeAll(let predicate):
        set = set.filter { !predicate($0) }

      case .set(let newValue):
        set = newValue
    }
  }
}

