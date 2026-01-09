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
  let phase: GesturePhase
  
  public init(
    offset: CGSize = .zero,
    phase: GesturePhase = .none
  ) {
    self.offset = offset
    self.phase = phase
  }
}
