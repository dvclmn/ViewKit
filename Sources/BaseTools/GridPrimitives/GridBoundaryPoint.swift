//
//  Model+BoundaryPoint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/8/2025.
//

import SwiftUI

public enum GridBoundaryPoint: String, CaseIterable, Identifiable {

  /// Row edges
  case top
  case bottom

  /// Column edges
  case leading
  case trailing

  /// Corners
  case topLeading
  case bottomLeading
  case topTrailing
  case bottomTrailing
}

extension GridBoundaryPoint {

  public init(fromEdge edge: GridEdge) {
    self =
      switch edge {
        case .top: .top
        case .trailing: .trailing
        case .bottom: .bottom
        case .leading: .leading
      }
  }

  public init(fromUnitPoint unitPoint: UnitPoint) {
    self =
      switch unitPoint {
        case .topLeading: .topLeading
        case .topTrailing: .topTrailing
        case .bottomLeading: .bottomLeading
        case .bottomTrailing: .bottomTrailing

        case .top: .top
        case .trailing: .trailing
        case .leading: .leading
        case .bottom: .bottom

        default: fatalError("Unsupported unit point: \(unitPoint)")
      }
  }
}

extension GridBoundaryPoint {

  public var name: String { rawValue }

  public var id: String { rawValue }

  public var toAlignment: Alignment {
    toUnitPoint.toAlignment
  }

  public var toLayoutAxis: Axis? {
    if toUnitPoint.isHorizontalEdge {
      return .horizontal
    } else if toUnitPoint.isVerticalEdge {
      return .vertical
    } else {
      return nil
    }
  }

  //  public var debugColour: Color {
  //    toUnitPoint.debugColour
  //  }

  public var toUnitPoint: UnitPoint {
    switch self {
      case .topLeading: UnitPoint.topLeading
      case .topTrailing: UnitPoint.topTrailing
      case .bottomLeading: UnitPoint.bottomLeading
      case .bottomTrailing: UnitPoint.bottomTrailing

      case .top: UnitPoint.top
      case .trailing: UnitPoint.trailing
      case .leading: UnitPoint.leading
      case .bottom: UnitPoint.bottom
    }
  }

  /// Checks whether a size delta is valid for the control point.
  public func isValidSizeDelta(
    from oldSize: CGSize,
    to newSize: CGSize,
  ) -> Bool {
    switch self {
      case .top, .bottom:
        oldSize.width == newSize.width

      case .leading, .trailing:
        oldSize.height == newSize.height

      case .topLeading, .bottomLeading, .topTrailing, .bottomTrailing:
        /// Both axes are allowed to change at corners
        true
    }
  }

  public var gridEdge: GridEdge? {
    switch self {
      case .top: .top
      case .bottom: .bottom
      case .leading: .leading
      case .trailing: .trailing
      default: nil
    }
  }

  public var isRowEdge: Bool {
    gridEdge?.isRowEdge ?? false
  }

  public var isColumnEdge: Bool {
    gridEdge?.isColumnEdge ?? false
  }

  public var isCorner: Bool {
    self == .topLeading
      || self == .topTrailing
      || self == .bottomLeading
      || self == .bottomTrailing
  }

  public var affectedEdges: GridEdge.Set {
    switch self {
      case .top: [.top]
      case .bottom: [.bottom]
      case .leading: [.leading]
      case .trailing: [.trailing]
      case .topLeading: [.top, .leading]
      case .topTrailing: [.top, .trailing]
      case .bottomLeading: [.bottom, .leading]
      case .bottomTrailing: [.bottom, .trailing]
    }
  }

  /// Note: `centre` anchor forces both opposing edges to be included
  public func edgesToResize(anchor: UnitPoint) -> GridEdge.Set {

    /// Start with what the dragged point says
    var edges = self.affectedEdges

    if anchor == .center {
      if edges.contains(.leading) || edges.contains(.trailing) {
        edges.insert([.leading, .trailing])
      }
      if edges.contains(.top) || edges.contains(.bottom) {
        edges.insert([.top, .bottom])
      }
    }

    /// Remove any edges that pass through the anchor
    if anchor.x == 0.0 { edges.remove(.leading) }
    if anchor.x == 1.0 { edges.remove(.trailing) }
    if anchor.y == 0.0 { edges.remove(.top) }
    if anchor.y == 1.0 { edges.remove(.bottom) }

    return edges
  }

}

extension UnitPoint {
  public var gridBoundaryPoint: GridBoundaryPoint {
    switch self {
      case .topLeading: .topLeading
      case .top: .top
      case .topTrailing: .topTrailing
      case .trailing: .trailing
      case .bottomTrailing: .bottomTrailing
      case .bottom: .bottom
      case .bottomLeading: .bottomLeading
      case .leading: .leading

      default:
        fatalError(
          "Unsupported unit point: \(self), for conversion to GridBoundaryPoint.")
    }
  }
}
