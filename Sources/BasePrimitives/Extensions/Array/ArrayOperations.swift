//
//  ArrayOperations.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/2/2026.
//

public enum ArrayOperation<Element> {
  case append(Element)
  case append(contentsOf: [Element])
  case insert(Element, at: Int)
  case remove(at: Int)
  case removeAll(where: (Element) -> Bool)
  case set([Element])
  
  func apply(to array: inout [Element]) {
    switch self {
      case let .append(element):
        array.append(element)
        
      case let .append(contentsOf: elements):
        array.append(contentsOf: elements)
        
      case let .insert(element, index):
        array.insert(element, at: index)
        
      case let .remove(index):
        guard array.indices.contains(index) else { return }
        array.remove(at: index)
        
      case let .removeAll(predicate):
        array.removeAll(where: predicate)
        
      case let .set(newValue):
        array = newValue
    }
  }
}
