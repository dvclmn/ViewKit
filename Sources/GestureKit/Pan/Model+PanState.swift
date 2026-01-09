//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import Foundation
import CoreGraphics

public struct PanState: Sendable {
  var offset: CGSize
  var phase: GesturePhase
  
  static let initial: Self = .init()
  
  public init(
    offset: CGSize = .zero,
    phase: GesturePhase = .none
  ) {
    self.offset = offset
    self.phase = phase
  }
}
extension PanState {
//  mutating func update(phase: GesturePhase) {
//    
//  }
  mutating func translate(by delta: CGSize) {
    offset.width -= delta.width
    offset.height -= delta.height
  }
  
  mutating func updatePhase(to new: GesturePhase) {
    phase = new
//    offset.width -= delta.width
//    offset.height -= delta.height
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
