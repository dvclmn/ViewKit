//
//  GridGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/2/2026.
//

import Foundation

/// Intended as a bit of an analogue to CanvasGeometry for Grid artwork
public struct GridGeometry: GeometryContext {
  /// A rect, not a size, to express safe area insets
  public let viewportRect: CGRect
  public let subjectSize: GridDimensions
}
