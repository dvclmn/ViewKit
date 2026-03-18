//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable {
  
  /// The viewport bounds in screen space (safe area applied).
  public var viewportRect: Rect<ScreenSpace>
  
  /// The artwork’s resolved frame, also in screen space
  public var artworkFrameInViewport: Rect<ScreenSpace>
  public var anchor: UnitPoint
  
  /// The artwork’s intrinsic size in its own local canvas space.
  public var canvasSize: Size<CanvasSpace>

  public static var zero: Self { .init() }

  public init(
    viewportRect: Rect<ScreenSpace> = .zero,
    artworkFrameInViewport: Rect<ScreenSpace> = .zero,
    canvasSize: Size<CanvasSpace> = .zero,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.artworkFrameInViewport = artworkFrameInViewport
    self.canvasSize = canvasSize
    self.anchor = anchor
  }
}
