//
//  GestureAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/1/2026.
//

import CoreTools
import SwiftUI

public protocol CanvasGestureState: Sendable {

  /// E.g. CGSize for pan
  associatedtype Value

  var value: Value { get set }
  var phase: InteractionPhase { get set }

  init(_ value: Value, phase: InteractionPhase)

  /// A value for 'at rest'
  static var initialValue: Value { get }

  mutating func update(_ newValue: Value, phase: InteractionPhase)
  mutating func updatePhase(_ phase: InteractionPhase)
}

extension CanvasGestureState {
  public var isActive: Bool { phase.isActive }

  public static var initial: Self {
    .init(Self.initialValue, phase: .none)
  }

  public mutating func update(_ newValue: Value, phase: InteractionPhase) {
//    print("Updating `CanvasGestureState` with value \(newValue) and phase \(phase)")
    self.value = newValue
    self.phase = phase
  }

  public mutating func updatePhase(_ phase: InteractionPhase) {
    self.phase = phase
  }
}

extension CanvasGestureState where Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    self.value.width += delta.width
    self.value.height += delta.height
    self.phase = phase
  }
}

public protocol ClampedGestureState: CanvasGestureState {
  func clamped(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> CGSize
}

extension ClampedGestureState {
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
