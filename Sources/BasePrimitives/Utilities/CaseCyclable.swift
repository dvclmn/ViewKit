//
//  CaseCyclable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import Foundation

public protocol CaseCyclable: CaseIterable, Equatable, Sendable
where
AllCases: RandomAccessCollection,
AllCases.Index == Int
{
  static var defaultCase: Self { get }
}

extension CaseCyclable {
  public func toNext(wrapping: Bool = true) -> Self {
    let cases = Self.allCases
    /// Find current position
    guard let currentIndex = cases.firstIndex(of: self) else { return Self.defaultCase }
    
    let nextIndex = cases.index(after: currentIndex)
    
    if nextIndex != cases.endIndex {
      return cases[nextIndex]
    } else {
      return wrapping ? (cases.first ?? Self.defaultCase) : self
    }
  }
  
  public func toPrevious(wrapping: Bool = true) -> Self {
    let cases = Self.allCases
    guard let currentIndex = cases.firstIndex(of: self) else { return Self.defaultCase }
    
    if currentIndex != cases.startIndex {
      let prevIndex = cases.index(before: currentIndex)
      return cases[prevIndex]
    } else {
      return wrapping ? (cases.last ?? Self.defaultCase) : self
    }
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
