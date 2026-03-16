//
//  InteractionSource.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/3/2026.
//

import Foundation

public enum InteractionChannel: Sendable, Equatable, Comparable {
  /// e.g., trackpad magnify, two-finger pan
  case hardwareGesture

  /// e.g., Space → Pan
  case springLoaded

  /// e.g., Zoom tool drag
  case toolPointer

  case hover
}

extension InteractionChannel {
  public var priority: Int {
    switch self {
      case .hardwareGesture: 3
      case .springLoaded: 2
      case .toolPointer: 1
      case .hover: 0
    }
  }
}

public enum InteractionSource: Sendable, Equatable {
  case gesture(
    GestureKind,
    channel: InteractionChannel = .hardwareGesture
  )
  case pointerDrag(
    PointerDragKind,
    channel: InteractionChannel = .toolPointer
  )
  case keyboard(
    channel: InteractionChannel = .springLoaded
  )
  
  /// Anything not initiated directly by a user input device.
  /// E.g. A Fit to screen / Zoom to Selection command,
  /// auto-centering the canvas after a resize, etc.
  case programmatic(
    channel: InteractionChannel = .toolPointer
  )

  public var channel: InteractionChannel {
    switch self {
      case .gesture(_, let c), 
          .pointerDrag(_, let c), 
          .keyboard(let c), 
          .programmatic(let c):
        return c
    }
  }
}

public enum GestureKind: Sendable, Equatable {
  case magnify
  case pan
  case rotate
}

public struct PointerDragKind: Sendable, Equatable {

  public enum Button: Sendable {
    case primary
    case secondary
    case middle
  }

  public var button: Button
  public var modifiers: Modifiers
}
