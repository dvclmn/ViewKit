//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import Foundation
import CoreGraphics

public struct PanState {
  let offset: CGSize
  let phase: PanPhase
  
  public init(offset: CGSize = .zero, phase: PanPhase = .inactive) {
    self.offset = offset
    self.phase = phase
  }
}

public enum PanPhase {
  case inactive
  case active
//  case active(delta: CGSize)
  case ended
//  case ended(finalDelta: CGSize)
  case cancelled
}
