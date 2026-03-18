//
//  Interaction+Kind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import EnumMacros
import SwiftUI

/// I'm getting caught up on needing to 'hook in' to e.g. the Swipe Gesture,
/// which typically informs Pan, but could drive other things too.
///
/// I should be able to justify what else may need that data, and then how
/// it should be structured (e.g. is it based on selected Tool?)

@MetaEnum
public enum InteractionKind {
  case pinching(magnification: CGFloat, anchor: UnitPoint)
  case swiping(delta: Size<ScreenSpace>, location: Point<ScreenSpace>)
  case rotating(Angle)

  case tapping(PointerButton = .primary, location: Point<ScreenSpace>)
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
