//
//  ControlKind.swift
//  BaseDemos
//
//  Created by Dave Coleman on 12/2/2026.
//

//import VectorKit

enum ControlKind: Sendable {
  case wave  // Dynamic
//  case wave(AnyWaveKey)  // Dynamic
  case `static`  // E.g. slider-only, no wave/time base control
  case none  // No control over this property
}
