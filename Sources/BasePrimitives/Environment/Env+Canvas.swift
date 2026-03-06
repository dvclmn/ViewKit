//
//  CanvasCoordinateSpace.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI

extension EnvironmentValues {

  /// This is usable by both Canvas and Grid domains. Describes the anchor
  /// used for SwiftUI layout by the main Artwork View in a CanvasView.
  /// Important for coordinate space calculations.
  @Entry public var canvasAnchor: UnitPoint = .center

  @Entry public var canvasState: Binding<CanvasState>?

  /// From CanvasKit
  //  @Entry public var zoomLevel: Double = 1.0
  //  @Entry public var panOffset: CGSize = .zero
  //  @Entry public var rotation: Angle = .zero
  //  @Entry public var pointerLocation: CGPoint?

  public var zoomLevel: Double {
    canvasState?.wrappedValue.zoomLevel ?? 1.0
  }
  public var panOffset: CGSize {
    canvasState?.wrappedValue.panOffset ?? .zero
  }
  public var rotation: Angle {
    canvasState?.wrappedValue.rotation ?? .zero
  }
  public var pointerLocation: CGPoint? {
    canvasState?.wrappedValue.pointerLocation
  }

  @Entry public var zoomRange: ClosedRange<Double>?

  public var zoomClamped: Double {
    guard let zoomRange else { return zoomLevel }
    return zoomLevel.clamped(to: zoomRange)
  }

  /// Aka artwork size, document size
  @Entry public var canvasSize: Size<CanvasSpace>?
  @Entry public var canvasBackground: Color = Color(white: 0.04)
}
