//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreGraphics
import CoreTools
import Foundation

public struct PanState: CanvasGestureState {
  public static var initialValue: CGSize { .zero }
  public var value: CGSize
  public var phase: InteractionPhase
//
  public init(
    _ value: CGSize = .zero,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}

extension PanState {
  public static var centered: Self { .init(.zero) }

  public var pan: CGSize { value }

  public func clamped(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> CGSize {
    let artwork = geometry.canvasSize
    let viewport = geometry.viewportSize
    let scaledArtwork = artwork * zoom

    let maxX = max((scaledArtwork.width - viewport.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewport.height) / 2, 0)

    return CGSize(
      width: value.width.clamped(to: -maxX...maxX),
      height: value.height.clamped(to: -maxY...maxY)
    )
  }
}
