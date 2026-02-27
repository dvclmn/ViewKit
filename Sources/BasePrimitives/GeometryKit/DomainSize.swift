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
  //  static var zero: Self { get }
  var toCGSize: CGSize? { get }
  //  func toCGSize(using unitSize: CGSize) -> CGSize?
}

//extension DomainSize {
//  public var isZero: Bool { self == .zero }
//}

// MARK: - Conformances
extension CGSize: DomainSize {
  public typealias Value = CGFloat

  public var toCGSize: CGSize? { self }
  //  public func toCGSize(using unitSize: CGSize) -> CGSize? { self }
}

extension UnitSize: DomainSize {
  //extension GridDimensions: DomainSize {

  public typealias Value = UnitLength
  //  public static var zero: Self { . }
  //  public static let zero: GridDimensions = .init(0, 0)

  public var toCGSize: CGSize? { screenSize }
  //  public func toCGSize(using unitSize: CGSize) -> CGSize? {
  //    toScreenSize(using: unitSize)
  //  }
}
