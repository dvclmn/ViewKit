//
//  Edge.swift
//  Collection
//
//  Created by Dave Coleman on 20/12/2024.
//

import InteractionKit
import SwiftUI

extension VerticalEdge {
  public var toAlignment: VerticalAlignment {
    switch self {
      case .top: .top
      case .bottom: .bottom
    }
  }
}

extension HorizontalEdge {
  public var toAlignment: HorizontalAlignment {
    switch self {
      case .leading: .leading
      case .trailing: .trailing
    }
  }
}

extension Edge {

  /// The physical axis this edge resides on in a standard coordinate system.
  public var toAxis: Axis {
    //    let mapping: AxisMapping = .identity
    switch self {
      case .top, .bottom: return .vertical
      case .leading, .trailing: return .horizontal
    }
  }

  /// Resolves which logical axis this edge belongs to.
  /// Assumes `identity` for ``AxisMapping`` as the baseline.
  public var toGeometryAxis: GeometryAxis {
    let mapping: AxisMapping = .identity
    /// 1. Get the physical reality of the edge (.top -> .vertical)
    let physical = self.toAxis

    /// 2. Ask the mapping what that physical axis represents logically
    return mapping.map(physical)
  }

  public var isVertical: Bool {
    self.toGeometryAxis.isVertical
  }

  public var isHorizontal: Bool {
    self.toGeometryAxis.isHorizontal
  }

  public static let zero: Double = 0.00
  public static let quarter: Double = 0.25
  public static let halfway: Double = 0.5
  public static let full: Double = 1.0

  public var off: UnitPoint {
    switch self {
      case .top:
        UnitPoint(x: Edge.halfway, y: Edge.zero)
      case .leading:
        UnitPoint(x: Edge.zero, y: Edge.halfway)
      case .bottom:
        UnitPoint(x: Edge.halfway, y: Edge.full)
      case .trailing:
        UnitPoint(x: Edge.full, y: Edge.halfway)
    }
  }

  public var on: UnitPoint {
    UnitPoint(x: Edge.halfway, y: Edge.halfway)
  }

  public var onQuarter: UnitPoint {
    switch self {
      case .top:
        UnitPoint(x: Edge.halfway, y: Edge.quarter)
      case .leading:
        UnitPoint(x: Edge.quarter, y: Edge.halfway)
      case .bottom:
        UnitPoint(x: Edge.halfway, y: Edge.quarter)
      case .trailing:
        UnitPoint(x: Edge.quarter, y: Edge.halfway)
    }
  }

  public var name: String {
    switch self {
      case .top: "Top"
      case .leading: "Leading"
      case .bottom: "Bottom"
      case .trailing: "Trailing"
    }
  }

  public var toAlignment: Alignment {
    switch self {
      case .top: .top
      case .bottom: .bottom
      case .leading: .leading
      case .trailing: .trailing

    }
  }
  public var toSet: Edge.Set {
    switch self {
      case .top: .top
      case .leading: .leading
      case .bottom: .bottom
      case .trailing: .trailing
    }
  }

  public var toAlignmentOpposing: Alignment {
    toAlignment.toOpposing
  }
}
