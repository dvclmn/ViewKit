//
//  CaseCyclable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import Foundation

public protocol CaseCyclable: CaseIterable, Equatable, Sendable where AllCases: RandomAccessCollection {
  static var defaultCase: Self { get }
}

extension CaseCyclable {

  /// Shared navigation helper for moving to the next/previous case with optional wrapping
  private func _move(_ direction: _Direction, wrapping: Bool) -> Self {
    let cases = Self.allCases
    guard let currentIndex else { return Self.defaultCase }

    switch direction {
    case .forward:
      let nextIndex = cases.index(after: currentIndex)
      if nextIndex == cases.endIndex {
        return wrapping ? (cases.first ?? Self.defaultCase) : self
      } else {
        return cases[nextIndex]
      }

    case .backward:
      if currentIndex == cases.startIndex {
        return wrapping ? (cases.last ?? Self.defaultCase) : self
      } else {
        let prevIndex = cases.index(before: currentIndex)
        return cases[prevIndex]
      }
    }
  }

  public func toNext(wrapping: Bool = true) -> Self {
    _move(.forward, wrapping: wrapping)
  }

  public func toPrevious(wrapping: Bool = true) -> Self {
    _move(.backward, wrapping: wrapping)
  }

  private var currentIndex: Self.AllCases.Index? {
    Self.allCases.firstIndex(of: self)
  }
}

extension CaseCyclable {
  public var isAtBeginning: Bool { self == Self.allCases.first }
  public var isAtEnd: Bool { self == Self.allCases.last }
  //
  //  public func toNext(wrapping: Bool = true) -> Self {
  //    Self.allCases.nextElement(after: self, wrapping: wrapping) ?? Self.defaultCase
  //  }
  //
  //  public func toPrevious(wrapping: Bool = true) -> Self {
  //    Self.allCases.previousElement(before: self, wrapping: wrapping) ?? Self.defaultCase
  //  }
  //
  //  public mutating func moveForward(wrapping: Bool = true) {
  //    self = toNext(wrapping: wrapping)
  //  }
  //  public mutating func moveBackward(wrapping: Bool = true) {
  //    self = toPrevious(wrapping: wrapping)
  //  }
}
