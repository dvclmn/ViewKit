//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable {
  public var viewportRect: CGRect
  public var canvasAnchor: UnitPoint
  public var canvasSize: CGSize

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportRect: CGRect = .zero,
    canvasSize: CGSize = .zero,
    canvasAnchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.canvasSize = canvasSize
    self.canvasAnchor = canvasAnchor
  }
}

extension CanvasGeometry {
  public var isValidForCoordinateMapping: Bool {
    viewportRect.width > 0
      && viewportRect.height > 0
      && canvasSize.width > 0
      && canvasSize.height > 0
  }

  public func viewportContext(
    zoom: CGFloat,
    pan: CGSize
  ) -> ViewportContext {
    ViewportContext(
      viewportRect: viewportRect,
      pan: Point<ScreenSpace>(x: pan.width, y: pan.height),
      zoom: zoom,
      canvasSize: Size<CanvasSpace>(
        width: canvasSize.width,
        height: canvasSize.height
      ),
      canvasAnchor: canvasAnchor
    )
  }
}

//extension CanvasGeometry: CustomStringConvertible {
//  public var description: String {
//    DisplayString {
//      Labeled("Viewport Rect", value: viewportRect)
//      Labeled("Canvas", value: canvasSize)
//    }
//    .decimalPlaces(0)
//    .labelStyle(.none)
//    .text
//
//  }
//}
