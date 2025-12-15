//
//  Axis2D.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import Foundation

/// Notes on Axis stuff:
///
/// ## Axis
/// - Horizontal vs vertical, a direction in space
/// - A purely spatial concept
/// - ``Axis2D``, ``AxisRepresentable``,  SwiftUI's `Axis`, etc
///
/// ## Dimension
/// - Width vs height. Semantics
/// - What `DimensionToAxisConvention` aims to disambiguate
/// - Width and height = labels applied to axes via a convention

/// Exists so I don't need to import SwiftUI just for an Axis type
public enum Axis2D: Int8, CaseIterable, Codable {
  case horizontal
  case vertical
}

public protocol AxisRepresentable: Equatable, CaseIterable where AllCases == [Self] {
  static var horizontal: Self { get }
  static var vertical: Self { get }
}

extension AxisRepresentable {
  public static var allCases: AllCases {
    [Self.horizontal, Self.vertical]
  }

  /// Important: This defaults to a``AxisConvention``
  /// of Width == Horizontal and Height == Vertical
  ///
  /// If this is not true for your domain,
  /// then do not use the below two properties.
  public static var width: Self { .horizontal }
  public static var height: Self { .vertical }

  /// Caution: This assumes a specific convention;
  /// Width == Horizontal == Columns, and
  /// Height == Vertical == Rows.
  ///
  /// If that does not apply for your use case, do not use these.
  public static var columns: Self { .horizontal }
  public static var rows: Self { .vertical }

  public var name: String {
    switch self {
      case .horizontal: "X"
      case .vertical: "Y"
      default: "Unknown Axis \(self)"
    }
  }

  public func midPoint(from rect: CGRect) -> CGFloat {
    switch self {
      case .horizontal: return rect.midX
      case .vertical: return rect.midY
      default: fatalError("Unknown Axis: \(self)")
    }
  }

}
