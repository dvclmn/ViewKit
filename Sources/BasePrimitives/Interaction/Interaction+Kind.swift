//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import Foundation

public enum InteractionKind: Equatable {
  case pointer(Pointer)
  case gesture(Gesture)
  case idle

  public enum Pointer: Equatable {
    case tap
    case tapDrag
    case hover
    case forceTouch
  }

  /// These are all two finger gestures only
  public enum Gesture: Equatable {
    case pan
    case pinch
    case rotate
  }
}
