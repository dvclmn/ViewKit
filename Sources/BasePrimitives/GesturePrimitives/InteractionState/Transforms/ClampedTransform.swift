//
//  ClampedTransform.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

import Foundation

public protocol ClampedInteraction: ContinuousInteraction {
  func clamped(to geometry: CanvasGeometry, zoom: CGFloat) -> Value
}

extension ClampedInteraction where Value == CGSize {
  public func clamped(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> CGSize {
    let artwork = geometry.canvasCGSize
    let viewportRect = geometry.viewportRect
    let scaledArtwork = artwork * zoom
    
    let maxX = max((scaledArtwork.width - viewportRect.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewportRect.height) / 2, 0)
    
//    let current = self.value ?? Self.initialValue ?? .zero
    
    return CGSize(
      width: value.width.clamped(to: -maxX...maxX),
      height: value.height.clamped(to: -maxY...maxY)
    )
  }
}
