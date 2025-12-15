//
//  Axis.swift
//  Collection
//
//  Created by Dave Coleman on 30/10/2024.
//

import SwiftUI

extension Axis: AxisRepresentable {}

extension Axis {
  public var toAxisSet: Axis.Set {
    switch self {
      case .horizontal: [.horizontal]
      case .vertical: [.vertical]
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
}

extension Axis {

  public enum MinMax {
    case minWidth
    case maxWidth
    case minHeight
    case maxHeight
  }

}
