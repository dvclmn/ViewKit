//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable {
  //public struct CanvasGeometry: Sendable, Equatable, CanvasViewportContext {
  public var viewportRect: Rect<ScreenSpace>
  public var canvasFrameInViewport: Rect<CanvasSpace>
  public var anchor: UnitPoint
  //  public var canvasSize: CGSize
  public var canvasSize: Size<CanvasSpace>

  public static var zero: Self { .init() }

  public init(
    viewportRect: Rect<ScreenSpace> = .zero,
    canvasFrameInViewport: Rect<CanvasSpace> = .zero,
    //    canvasSize: CGSize = .zero,
    canvasSize: Size<CanvasSpace> = .zero,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.canvasFrameInViewport = canvasFrameInViewport
    self.canvasSize = canvasSize
    self.anchor = anchor
  }
}
