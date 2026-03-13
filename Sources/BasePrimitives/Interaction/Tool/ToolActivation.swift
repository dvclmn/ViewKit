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
  
  public init(tool: CanvasTool, binding: ToolBinding, startedAt: Date = Date(), key: KeyEquivalent) {
    self.tool = tool
    self.binding = binding
    self.startedAt = startedAt
    self.key = key
  }
}


public enum ActivationMode: Sendable {
  case hold  // spring-load while key is held
  case sticky  // press to switch until changed
  case toggle  // press to toggle on/off
}
