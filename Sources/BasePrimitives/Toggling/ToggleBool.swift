//
//  ToggleBool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/9/2025.
//

import Foundation

/// Determines the target state when toggling a collection of boolean values
public enum ToggleStrategy {
  /// If all same state, toggle. If mixed, set all to true
  case preferTrue

  /// If all same state, toggle. If mixed, set all to false
  case preferFalse

  /// If all same state, toggle. If mixed, set to majority state
  case followMajority

  /// Invert the state of each toggle to its opposite
  case invert
}

/// Usage examples:
/// ```
/// extension Collection where Element == Bool {
///   // Convenience method that combines the logic for easy use
///   func shouldToggleIndividually(strategy: ToggleStrategy = .preferTrue) -> Bool {
///     return toggleAction(strategy: strategy) == nil
///   }
/// }
/// ```
extension Collection where Element == Bool {
  
  /// Decide a single “target” value if the strategy calls for it.
  /// Returns `nil` when each element must be flipped individually (the `.invert` case).
  func target(for strategy: ToggleStrategy) -> Bool? {
    guard !isEmpty else { return true }
    
    let trueCount  = filter { $0 }.count
    let falseCount = count - trueCount
    
    let allTrue  = trueCount  == count
    let allFalse = falseCount == count
    
    switch strategy {
      case .preferTrue:
        return allTrue ? false : true
        
      case .preferFalse:
        return allFalse ? true : false
        
      case .followMajority:
        if allTrue  { return false }
        if allFalse { return true  }
        return trueCount >= falseCount
        
      case .invert:
        return nil   // signal: toggle each item individually
    }
  }
}

/// Usage example:
///
/// ```
/// var items = [Item(flag: true), Item(flag: false)]
/// items.toggleAll(at: \.flag, strategy: .invert)
/// ```
extension MutableCollection {
  public mutating func toggleAll(
    at keyPath: WritableKeyPath<Element, Bool>,
    strategy: ToggleStrategy
  ) {
    let states = self.map { $0[keyPath: keyPath] }
    
    if let target = states.target(for: strategy) {
      for i in indices {
        self[i][keyPath: keyPath] = target
      }
    } else {
      for i in indices {
        self[i][keyPath: keyPath].toggle()
      }
    }
  }
}

extension Collection {
  func toggled(
    at keyPath: WritableKeyPath<Element, Bool>,
    strategy: ToggleStrategy
  ) -> [Element] {
    let states = self.map { $0[keyPath: keyPath] }
    return map { element in
      var copy = element
      if let target = states.target(for: strategy) {
        copy[keyPath: keyPath] = target
      } else {
        copy[keyPath: keyPath].toggle()
      }
      return copy
    }
  }
}
