//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreGraphics
import CoreTools
import Foundation

public struct PanState {
  private(set) var translation: CGSize
  private(set) var phase: InteractionPhase

  public init(
    _ translation: CGSize = .zero,
    phase: InteractionPhase = .none
  ) {
    self.translation = translation
    self.phase = phase
  }
}

extension PanState {
  public static var centered: Self { .init(.zero) }
  
  public var pan: CGSize {translation}

  public mutating func update(newValue: CGSize, phase: InteractionPhase) {
    translation = newValue
//    translation.width += delta.width
//    translation.height += delta.height
    self.phase = phase
  }
  
  public mutating func update(_ delta: CGSize, phase: InteractionPhase) {
    translation.width += delta.width
    translation.height += delta.height
    self.phase = phase
  }

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
      width: translation.width.clamped(to: -maxX...maxX),
      height: translation.height.clamped(to: -maxY...maxY)
    )
  }
}
