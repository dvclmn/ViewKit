//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable, ViewportGeometric {
  public var viewportRect: CGRect
  public var anchor: UnitPoint
  public var canvasSize: Size<CanvasSpace>

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportRect: CGRect = .zero,
    canvasSize: Size<CanvasSpace>,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.canvasSize = canvasSize
    self.anchor = anchor
  }
}

extension CanvasGeometry {
  public init?(
    viewportRect: CGRect,
    gridDimensions: GridDimensions,
    unitSize: CGSize,
    anchor: UnitPoint
  ) {
    guard let size = gridDimensions.toScreenSize(using: unitSize) else { return nil }
    self.init(
      viewportRect: viewportRect,
      canvasSize: Size<CanvasSpace>(fromCGSize: size),
      anchor: anchor
    )
  }
}
