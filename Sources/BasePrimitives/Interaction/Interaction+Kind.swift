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

  public enum Pointer: Equatable {
    case tap
    case tapDrag
    case hover
    case forceTouch
  }

  /// All two finger gestures only
  public enum Gesture: Equatable {
    case pan
    case pinch
    case rotate
  }
}

//import EnumMacros
//import SwiftUI
//

//@MetaEnum
//@AssociatedValues
//public enum InteractionKind: Sendable {
//  case tap(CGPoint)
//  case drag(CGRect)  // Aka tap and drag
//  case tapRanges(Set<Range<Int>>)  // For multi-select
//  case longPress(CGPoint)
//
//  case gestureZoom(CGFloat)  // Aka pinch and zoom
//  case gesturePan(CGSize)  // Aka two finger swipe
//  case gestureRotate(Angle)  // Two finger turn
//
//  case hover(CGPoint)
//  case none
//}
//
//extension InteractionKind.Meta: Sendable {}
//extension InteractionKind.Meta {
//  func keyPath() -> PartialKeyPath<InteractionHandler>? {
//    //  func keyPath<T>() ->  WritableKeyPath<InteractionHandler, T?>? {
//    switch self {
//      case .tap: \.tapLocation
//      case .drag: \.dragRect
//      case .tapRanges: nil
//      case .longPress: nil
//      case .gestureZoom: \.zoom
//      case .gesturePan: \.pan
//      case .gestureRotate: \.rotation
//      case .hover: \.hoverLocation
//      case .none: nil
//    }
//  }
//}
