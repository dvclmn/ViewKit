//
//  GestureKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import EnumMacros
import SwiftUI

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
  case zoom(ZoomOperation)  // Aka pinch and zoom
  case pan(CGSize)  // Aka two finger swipe
  case rotate(Angle)  // Two finger turn
}

/// This should be turned into a protocol or something in future
extension GestureKind {

}
