//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import Foundation
import CoreGraphics

public struct PanState: Sendable {
  let offset: CGSize
  let phase: GesturePhase
  
  static let initial: Self = .init()
  
  public init(
    offset: CGSize = .zero,
    phase: GesturePhase = .none
  ) {
    self.offset = offset
    self.phase = phase
  }
}

public struct ZoomState: Sendable {
  let zoom: CGFloat
  let phase: GesturePhase
  
  static let initial: Self = .init()
  
  public init(zoom: CGFloat = 1.0, phase: GesturePhase = .none) {
    self.zoom = zoom
    self.phase = phase
  }
}
