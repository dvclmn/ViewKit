//
//  Model+TouchPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 4/6/2025.
//

import AppKit

/// Similar-ish to ``InteractionPhase``, but based on
/// NSEvent's `NSTouch.Phase`
//public enum TouchPhase: String, Sendable, Equatable, Codable {
//  case began
//  case moved
//  case stationary
//  case ended
//  case cancelled
//  case touching
//  case any
//}
//
//extension TouchPhase {
//  public init(from nsTouchPhase: NSTouch.Phase) {
//    self =
//      switch nsTouchPhase {
//        case .began: .began
//        case .moved: .moved
//        case .stationary: .stationary
//        case .ended: .ended
//        case .cancelled: .cancelled
//        case .touching: .touching
//        case .any: .any
//        default: .any
//      }
//  }
//
//  var isResting: Bool {
//    self == .stationary
//  }
//}
