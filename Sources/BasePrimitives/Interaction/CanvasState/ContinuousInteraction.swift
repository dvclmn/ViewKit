//
//  ContinuousInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

public struct ContinuousInteraction<Value: Sendable & Equatable>: Equatable, Sendable {
  public var value: Value
  public var phase: InteractionPhase

  public var isActive: Bool {
    phase != .none && phase != .cancelled && phase != .ended
  }

  public init(_ value: Value, phase: InteractionPhase = .none) {
    self.value = value
    self.phase = phase
  }

  public mutating func update(_ value: Value, phase: InteractionPhase) {
    self.value = value
    self.phase = phase
  }
  
}

extension ContinuousInteraction where Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    self.value += delta
    self.phase = phase
  }
  public func clamped(
    to geometry: CanvasGeometry,
    zoom: CGFloat
  ) -> CGSize {
    let artwork = geometry.canvasCGSize
    let viewportRect = geometry.viewportRect
    let scaledArtwork = artwork * zoom

    let maxX = max((scaledArtwork.width - viewportRect.width) / 2, 0)
    let maxY = max((scaledArtwork.height - viewportRect.height) / 2, 0)

    return CGSize(
      width: value.width.clamped(to: -maxX...maxX),
      height: value.height.clamped(to: -maxY...maxY)
    )
  }
  
  
}

// MARK: - Continuous
/// Value-based: value is always present; define a default
/// E.g. Pan, zoom
//public protocol ContinuousInteraction: InteractionState {
//  associatedtype Value
//  var value: Value { get set }
//  static var initialValue: Value { get }
//  init(_ value: Value)
//}
//
//extension ContinuousInteraction {
//  public init(_ value: Value) { self.init(value) }
//  public mutating func update(_ newValue: Value) { value = newValue }
//
//  /// If type is phasic, can override with a phase-based rule
//  public var isActive: Bool { true }
//
//  public mutating func reset() { self.value = Self.initialValue }
//
//  public static var initial: Self { .init(Self.initialValue) }
//}
