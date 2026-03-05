//
//  Model+GeometryCapture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/9/2025.
//

import CoreTools
import SwiftUI

public protocol GeometryCapturable: Equatable, Sendable {
  //  var type: Self.Type { get }
  //  var transform: @Sendable (GeometryProxy) -> Self { get }
}
extension CGSize: GeometryCapturable {}
extension CGRect: GeometryCapturable {}
extension EdgeInsets: GeometryCapturable {}
extension SafeAreaRect: GeometryCapturable {}

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

  /// Note: This does not account for safe area insets at all
  public static var globalRect: GeometryCapture<CGRect> {
    .init(type: CGRect.self) { proxy in
      proxy.frame(in: .global)
    }
  }

  /// This captures three points of data, hoping to get proper
  /// sense of safe areas and view positoning
  public static var safeAreaRect: GeometryCapture<SafeAreaRect> {
    .init(type: SafeAreaRect.self) { proxy in
      return SafeAreaRect(
        size: proxy.size,
        safeInsets: proxy.safeAreaInsets,
        globalFrame: proxy.frame(in: .global)
      )
    }
  }

  public static func frameInScrollView(axis: Axis = .vertical) -> GeometryCapture<CGRect> {
    .init(type: CGRect.self) {
      $0.frame(in: .scrollView(axis: axis))
    }
  }
}
