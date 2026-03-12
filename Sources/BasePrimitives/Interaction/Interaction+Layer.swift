//
//  Interaction+Layer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/3/2026.
//

import Foundation

public enum InteractionLayer: Int, Equatable, Sendable {
  /// Two-finger pan/zoom/rotate — global, wins first
  case gesture

  /// Pointer actions while a spring-loaded tool is active
  case pointerWithSpringLoad

  /// Pointer actions with the effective tool
  case pointerWithTool

  /// Passive hover only
  case hover

}

extension InteractionLayer {
  var name: String {
    switch self {
      case .gesture: "Gesture"
      case .pointerWithSpringLoad: "Pointer + Spring-Loaded Tool"
      case .pointerWithTool: "Pointer + Effective Tool"
      case .hover: "Hover"
    }
  }
}
