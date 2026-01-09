//
//  GesturePhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import AppKit
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
  case pan(PanState)
  case zoom(ZoomAdjustment)
//  case zoom(ZoomState)
  case rotate(RotateState)
  case select
  case resize
  case none
  
  public var name: String {
    switch self {
      case .pan: "Pan"
      case .zoom: "Zoom"
      case .rotate: "Rotate"
      case .select: "Select"
      case .resize: "Resize"
      case .none: "None"
    }
  }
}

extension GestureKind {
  
  /// This probably should be scrutinised more
  public var interactionType: Interaction {
    switch self {
      case .pan: .gesturePan
      case .zoom: .gestureZoom
      case .rotate: .gestureRotate
      case .select: .dragSelect
      case .resize: .dragResize
      case .none: .none
    }
  }
}

//public enum ZoomPhase: Sendable {
//  case inactive
//  case active
//  case ended
//}

// From NSEvent.Phase
public enum GesturePhase: String, Sendable {
  case began
  case stationary
  case changed
  case ended
  case cancelled
  case mayBegin
  case none
}
extension GesturePhase {
  public init(from nsEventPhase: NSEvent.Phase) {
    self =
      switch nsEventPhase {
        case .began: .began
        case .stationary: .stationary
        case .changed: .changed
        case .ended: .ended
        case .cancelled: .cancelled
        case .mayBegin: .mayBegin
        default: .none
      }
  }
  public var name: String {
    switch self {
      case .mayBegin: "May Begin"
      default: rawValue.capitalized
    }
  }

  var isInteractive: Bool {
    switch self {
      case .began, .changed: true
      default: false
    }
  }
}

//public struct Phase : OptionSet, @unchecked Sendable {
//
//  public init(rawValue: UInt)
//
//  public static var began: NSEvent.Phase { get }
//
//  public static var stationary: NSEvent.Phase { get }
//
//  public static var changed: NSEvent.Phase { get }
//
//  public static var ended: NSEvent.Phase { get }
//
//  public static var cancelled: NSEvent.Phase { get }
//
//  public static var mayBegin: NSEvent.Phase { get }
//  }
