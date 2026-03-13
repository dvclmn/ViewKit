//
//  ToolActivation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

public struct ToolActivation: Hashable, Sendable {
  public let tool: CanvasTool
  public let binding: ToolBinding
  public let startedAt: Date
  public let key: KeyEquivalent

  public init(
    tool: CanvasTool,
    binding: ToolBinding,
    startedAt: Date = Date(),
    key: KeyEquivalent
  ) {
    self.tool = tool
    self.binding = binding
    self.startedAt = startedAt
    self.key = key
  }
}

public enum ActivationMode: Sendable {
  /// Spring-load while key is held
  case hold

  /// Press to switch tool; remains active until changed
  case sticky

  /// Press to toggle on/off
  case toggle

}
