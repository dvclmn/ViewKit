//
//  Axis2D.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/12/2025.
//

import SwiftUI

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
public enum Axis2D: Int, CaseIterable, Codable {
  case horizontal
  case vertical
}

extension Axis2D {
  public var isHorizontal: Bool { self == .horizontal }
  public var isVertical: Bool { self == .vertical }
}

extension Axis {
  public var toAxis2D: Axis2D {
    switch self {
      case .horizontal: .horizontal
      case .vertical: .vertical
    }
  }
}
