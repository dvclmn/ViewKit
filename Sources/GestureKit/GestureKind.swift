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
public enum GestureKind: Sendable {
  case zoom(CGFloat) // Aka pinch and zoom
  case pan(CGSize) // Aka two finger swipe
  case rotate(Angle) // Two finger turn
  //  case pan(PanState)
  //  case zoom(ZoomAdjustment)
  //  //  case zoom(ZoomState)
  //  case rotate(RotateState)
  //  case select
  //  case resize
  //  case none
}

extension GestureKind {
  
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
