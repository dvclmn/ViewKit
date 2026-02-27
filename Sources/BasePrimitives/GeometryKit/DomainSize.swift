//
//  DomainSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import CoreGraphics
import Foundation

public protocol DomainSize: Equatable {
  associatedtype Value

  var width: Value { get }
  var height: Value { get }
  static var zero: Self { get }
  func toCGSize(using unitSize: CGSize) -> CGSize?

}

extension DomainSize {
  public var isZero: Bool { self == .zero }
}

extension CGSize: DomainSize {
  public typealias Value = CGFloat

  public func toCGSize(using unitSize: CGSize) -> CGSize? { self }
}

extension GridDimensions: DomainSize {
  public typealias Value = Int
  public static let zero: GridDimensions = .init(0, 0)

  public func toCGSize(using unitSize: CGSize) -> CGSize? {
    toScreenSize(using: unitSize)
  }
}
