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
  public func toNext(wrapping: Bool = true) -> Self {
    let cases = Self.allCases
    /// Find current position
    guard let currentIndex else { return Self.defaultCase }

    let nextIndex = cases.index(after: currentIndex)

    guard nextIndex != cases.endIndex else {
      return wrapping ? (cases.first ?? Self.defaultCase) : self
    }
    return cases[nextIndex]
  }

  public func toPrevious(wrapping: Bool = true) -> Self {
    let cases = Self.allCases
    guard let currentIndex else { return Self.defaultCase }

    guard currentIndex != cases.startIndex else {
      return wrapping ? (cases.last ?? Self.defaultCase) : self
    }
    let prevIndex = cases.index(before: currentIndex)
    return cases[prevIndex]
  }

  private var currentIndex: Self.AllCases.Index? {
    Self.allCases.firstIndex(of: self)
  }
}

extension CaseCyclable {
  public var isAtBeginning: Bool { self == Self.allCases.first }
  public var isAtEnd: Bool { self == Self.allCases.last }
}
