//
//  ZoomGestureEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import Foundation

public struct ZoomGestureEvent: Sendable {
  public var phase: InteractionPhase
  public var previousZoom: Double
  public var proposedZoom: Double
  public var magnification: Double
  public var magnificationDelta: Double
  public var isGestureStart: Bool
  
  public init(
    phase: InteractionPhase,
    previousZoom: Double,
    proposedZoom: Double,
    magnification: Double,
    magnificationDelta: Double,
    isGestureStart: Bool
  ) {
    self.phase = phase
    self.previousZoom = previousZoom
    self.proposedZoom = proposedZoom
    self.magnification = magnification
    self.magnificationDelta = magnificationDelta
    self.isGestureStart = isGestureStart
  }
}
