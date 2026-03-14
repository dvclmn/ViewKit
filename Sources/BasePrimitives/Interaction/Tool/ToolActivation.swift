//
//  ToolActivation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

/// A record of a spring-loaded tool activation.
///
/// When a `.hold` binding key is pressed, an activation is created with
/// `isArmed = false`. After the spring-load delay elapses, the activation
/// is armed and becomes the effective tool. If the key is released before
/// arming, the activation is silently discarded (brief tap = no tool switch).
public struct ToolActivation: Hashable, Sendable {
  public let tool: CanvasTool
  public let binding: ToolBinding
  public let startedAt: Date
  public let key: KeyEquivalent

  /// Whether the spring-load delay has elapsed and this activation is live.
  public var isArmed: Bool

  public init(
    tool: CanvasTool,
    binding: ToolBinding,
    startedAt: Date = Date(),
    key: KeyEquivalent,
    isArmed: Bool = false
  ) {
    self.tool = tool
    self.binding = binding
    self.startedAt = startedAt
    self.key = key
    self.isArmed = isArmed
  }
}

public enum ActivationMode: Sendable, Hashable {
  /// Spring-load while key is held (with debounce delay)
  case hold

  /// Press to switch tool; remains active until changed
  case sticky

  /// Press to toggle on/off
  case toggle
}
