//
//  GridCanvasGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import CoreGraphics
import SwiftUI

/// Intended as a bit of an analogue to CanvasGeometry for Grid artwork
public struct GridGeometry: GeometryContext, Sendable, Equatable {
  /// A rect, not a size, to express safe area insets
  public var viewportRect: CGRect
  public var subjectSize: UnitSize
  public var subjectAnchor: UnitPoint
  //  public var subjectSize: GridDimensions
  //  public var unitSize: CGSize

  public init(
    viewportRect: CGRect = .zero,
    subjectSize: UnitSize,
    subjectAnchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
    self.subjectAnchor = subjectAnchor
  }
}

extension GridGeometry {

  //  private var canvasSize: CGSize? {
  //    guard let unitSize else { return nil }
  //    guard let gridDimensions else { return nil }
  //
  //    //    let dimensions = gridCanvas.wrappedValue.gridDimensions
  //    return gridDimensions.toScreenSize(using: unitSize)
  //  }
}
