//
//  Model+GeometryCapture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/9/2025.
//

import SharedHelpers
import SwiftUI

//public struct Geometries: OptionSet, Sendable {
//  public init(rawValue: Int) {
//    self.rawValue = rawValue
//  }
//  public let rawValue: Int
//
//  public static let size = Self(rawValue: 1 << 0)
//  public static let scrollFrame = Self(rawValue: 1 << 1)
//  public static let safeInsets = Self(rawValue: 1 << 2)
//}

public struct SizeAndSafeInsets: Equatable, Sendable {
  let size: CGSize
  let safeInsets: EdgeInsets
}

public protocol GeometryCapturable: Equatable, Sendable {}
extension CGSize: GeometryCapturable {}
extension CGRect: GeometryCapturable {}
extension EdgeInsets: GeometryCapturable {}
extension SizeAndSafeInsets: GeometryCapturable {}

public struct GeometryCapture<T: GeometryCapturable>: Sendable {
  let type: T.Type
  let transform: @Sendable (GeometryProxy) -> T

  public init(
    type: T.Type,
    transform: @escaping @Sendable (GeometryProxy) -> T
  ) {
    self.type = type
    self.transform = transform
  }
}

extension GeometryCapture {
  public static var size: GeometryCapture<CGSize> {
    .init(type: CGSize.self) { $0.size }
  }

  public static var safeAreaInsets: GeometryCapture<EdgeInsets> {
    .init(type: EdgeInsets.self) { $0.safeAreaInsets }
  }

  public static var sizeAndSafeInsets: GeometryCapture<SizeAndSafeInsets> {
    .init(type: SizeAndSafeInsets.self) {
      SizeAndSafeInsets(size: $0.size, safeInsets: $0.safeAreaInsets)
    }
  }

  public static func frameInScrollView(axis: Axis = .vertical) -> GeometryCapture<CGRect> {
    .init(type: CGRect.self) {
      $0.frame(in: .scrollView(axis: axis))
    }
  }

}
