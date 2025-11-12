//
//  Axis.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//

import SwiftUI

extension Axis {

  /// Important: This defaults to a``DimensionToAxisConvention``
  /// of Width == Horizontal and Height == Vertical
  ///
  /// If this is not true for your domain,
  /// then do not use the below two properties.
  public static var width: Axis { .horizontal }
  public static var height: Axis { .vertical }

  /// Caution: This assumes a specific convention;
  /// Width == Horizontal == Columns, and
  /// Height == Vertical == Rows.
  ///
  /// If that does not apply for your use case, do not use these.
  public static var columns: Axis { .horizontal }
  public static var rows: Axis { .vertical }

  public var toAxisSet: Axis.Set {
    switch self {
      case .horizontal: [.horizontal]
      case .vertical: [.vertical]
    }
  }

  public var name: String {
    switch self {
      case .horizontal: "X"
      case .vertical: "Y"
    }
  }

  public func midPoint(from rect: CGRect) -> CGFloat {
    switch self {
      case .horizontal: return rect.midX
      case .vertical: return rect.midY
    }
  }
  
  public var toEdgeSet: Edge.Set {
    switch self {
      case .horizontal: return .horizontal
      case .vertical: return .vertical
    }
  }

  // TODO: Does this make sense? Should this be incorporated with `DimensionToAxisConvention`?
  public func getMinMax(_ axis: Axis.MinMax) -> Axis {
    switch axis {
      case .minWidth, .maxWidth:
        return .horizontal

      case .minHeight, .maxHeight:
        return .vertical
    }
  }

  public enum MinMax {
    case minWidth
    case maxWidth
    case minHeight
    case maxHeight
  }

}
