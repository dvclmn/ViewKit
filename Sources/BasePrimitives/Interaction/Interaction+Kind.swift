//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import EnumMacros
import SwiftUI

@MetaEnum
public enum InteractionKind {
  case pinching(magnification: CGFloat, anchor: UnitPoint)
  case panning(PanEvent)
  case rotating(Angle)

  case tapping(PointerButton, location: Point<ScreenSpace>)
  case forceTouch
  case dragging(
    from: Point<ScreenSpace>,
    current: Point<ScreenSpace>
  )
  case hovering(Point<ScreenSpace>)
  case idle
}

public enum PointerButton: Sendable {
  case primary
  case secondary
  case middle
}

//extension InteractionKind {
//  public enum TapKind {
//    case standard
//    case forceTouch
//  }

//  public enum Kind {
//    case gesture
//    case pointer
//    case none
//  }
//}

//extension Interaction {
//  public var kind: Interaction.Kind {
//    switch self {
//      case .pinch, .pan, .rotate: .gesture
//      case .tap, .forceTouch, .drag, .hover: .pointer
//      case .idle: .none
//    }
//  }
//}

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
