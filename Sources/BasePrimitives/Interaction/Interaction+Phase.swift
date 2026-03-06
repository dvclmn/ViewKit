//
//  GesturePhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import AppKit

public enum InteractionPhase: String, Sendable, Codable {
  case began
  case stationary
  case changed  // NSTouch = moved
  case ended
  case cancelled
  case mayBegin  // NSTouch = touching
  case any
  case none
}

extension InteractionPhase {
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

  public init(from nsTouchPhase: NSTouch.Phase) {
    self =
      switch nsTouchPhase {
        case .began: .began
        case .moved: .changed
        case .stationary: .stationary
        case .ended: .ended
        case .cancelled: .cancelled
        case .touching: .mayBegin
        case .any: .any
        default: .none
      }
  }

  public var name: String {
    switch self {
      case .mayBegin: "May Begin"
      default: rawValue.capitalized
    }
  }

  public var isActive: Bool {
    self == .began || self == .changed
  }
}
