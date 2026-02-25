//
//  Model+GeometryCapture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/9/2025.
//

import SharedHelpers
import SwiftUI

public protocol GeometryCapturable: Equatable, Sendable {
  //  var type: Self.Type { get }
  //  var transform: @Sendable (GeometryProxy) -> Self { get }
}
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
