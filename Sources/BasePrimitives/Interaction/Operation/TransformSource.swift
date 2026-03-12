//
//  TransformSource.swift
//  DrawString
//
//  Created by Dave Coleman on 11/3/2026.
//

/// How panning was initiated — useful for debug display and
/// for subtly different cursor/feedback behaviour.
public enum TransformSource: Equatable, Sendable {

  /// Two-finger trackpad swipe for Pan, pinch for Zoom
  case gesture

  /// Pan/Zoom tool selected, pointer drag
  case pointerDrag
//  case pointerDrag(ToolInvocation)
}

extension TransformSource {
  public var name: String {
    switch self {
      case .gesture: "Gesture"
      case .pointerDrag: "Pointer Drag"
//      case .pointerDrag(let invocation):

//        "Pointer Drag \(invocation.isSpringLoaded ? " , Spring Loaded" : "")"
    }
  }
}

public enum ToolInvocation: Sendable, Equatable {
  case standard
  case springLoaded

  var isSpringLoaded: Bool { self == .springLoaded }
}
