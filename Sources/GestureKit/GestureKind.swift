//
//  GestureKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import SwiftUI
import CoreTools

/// # Touch Gestures
/// - Zoom
/// - Pan
/// - Rotation
///
/// # Drag Gestures
/// - Pan
/// - Select
/// - Resize
/// - Tap (considered zero-length drag)
///
/// Tool-based (should only be allowed when x tool is selected)
/// - Pan (Drag)
/// - Select
/// - Resize
@MetaEnum
public enum GestureKind {
  case zoom(CGFloat)
  case pan(CGSize)
  case rotate(Angle)
  //  case pan(PanState)
  //  case zoom(ZoomAdjustment)
  //  //  case zoom(ZoomState)
  //  case rotate(RotateState)
  //  case select
  //  case resize
  //  case none

//  public var name: String {
//    switch self {
////      case .pinchAndZoom: "Pinch and Zoom"
////      case .twoFingerPan: "Two Finger Pan"
//    //      case .pan: "Pan"
//    //      case .zoom: "Zoom"
//    //      case .rotate: "Rotate"
//    //      case .select: "Select"
//    //      case .resize: "Resize"
//    //      case .none: "None"
//    }
//  }
}

//extension GestureKind {
//
//  /// This probably should be scrutinised more
//  public var interactionType: Interaction {
//    switch self {
//      case .pan: .gesturePan
//      case .zoom: .gestureZoom
//      case .rotate: .gestureRotate
//      case .select: .dragSelect
//      case .resize: .dragResize
//      case .none: .none
//    }
//  }
//}
