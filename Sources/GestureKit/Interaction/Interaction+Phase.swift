//
//  GesturePhase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import AppKit
import CoreTools

public enum InteractionPhase: String, Sendable {
  case began
  case stationary
  case changed
  case ended
  case cancelled
  case mayBegin
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
}
extension InteractionPhase {
  public var name: String {
    switch self {
      case .mayBegin: "May Begin"
      default: rawValue.capitalized
    }
  }

  var isActive: Bool {
    switch self {
      case .began, .changed: true
      default: false
    }
  }
}
