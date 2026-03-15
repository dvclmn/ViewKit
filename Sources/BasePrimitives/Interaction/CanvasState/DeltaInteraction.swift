//
//  DeltaInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/3/2026.
//

import Foundation

extension ContinuousInteraction where Value == Size<ScreenSpace> {
//extension ContinuousInteraction where Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    self.value += delta
    self.phase = phase
  }
  public func clamped<Space>(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> Size<Space> {
//  ) -> CGSize {
    let artwork = geometry.canvasCGSize
    let viewportRect = geometry.viewportRect
    let scaledArtwork = artwork * zoom

    let maxX = max((scaledArtwork.width - viewportRect.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewportRect.height) / 2, 0)

    return Size<Space>(
//    return CGSize(
      width: value.width.clamped(to: -maxX...maxX),
      height: value.height.clamped(to: -maxY...maxY)
    )
  }
}

public func += <Space>(lhs: inout Size<Space>, rhs: Size<Space>) {
  lhs.width += rhs.width
  lhs.height += rhs.height
}
