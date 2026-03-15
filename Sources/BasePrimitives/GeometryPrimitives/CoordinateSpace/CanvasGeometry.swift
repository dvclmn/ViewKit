//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable, CanvasViewportContext {
  public var viewportRect: CGRect
  public var anchor: UnitPoint
  public var canvasSize: Size<CanvasSpace>
  
  public static var zero: Self { .init() }

  public init(
    viewportRect: CGRect = .zero,
    canvasSize: Size<CanvasSpace> = .zero,
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
