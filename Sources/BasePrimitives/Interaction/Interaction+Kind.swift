//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import Foundation

public enum Interaction {
  case pinch
  case pan  // Aka scroll, swipe
  case rotate

  case tap
  case forceTouch
  case drag
  case hover
  case idle
}

extension Interaction {
  //  public enum TapKind {
  //    case standard
  //    case forceTouch
  //  }

  public enum Kind {
    case gesture
    case pointer
    case none
  }
}

extension Interaction {
  public var kind: Interaction.Kind {
    switch self {
      case .pinch, .pan, .rotate: .gesture
      case .tap, .forceTouch, .drag, .hover: .pointer
      case .idle: .none
    }
  }
}

//public enum InteractionKind: Equatable {
//  case pointer(Pointer)
//  case gesture(Gesture)
//  case idle
//
//  public enum Pointer: Equatable {
//    case tap
//    case tapDrag
//    case hover
//    case forceTouch
//  }
//
//  /// These are all two finger gestures only
//  public enum Gesture: Equatable {
//    case pan
//    case pinch
//    case rotate
//  }
//}
