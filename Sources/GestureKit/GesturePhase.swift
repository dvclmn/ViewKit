//
//  GesturePhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import AppKit
import CoreTools

@MetaEnum
public enum GestureKind {
  case pan(PanState)
  case zoom(ZoomState)
}

public enum ZoomPhase: Sendable {
  case inactive
  case active
  case ended
}


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
