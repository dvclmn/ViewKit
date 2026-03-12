//
//  Handler+Tool.swift
//  DrawString
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

public struct ToolHandler {

  /// Aka the Tool explicitly selected by the user, regardless of
  /// any spring-loading and other context
  public var selectedTool: CanvasTool = .select

  public var allTools: [CanvasTool] = [.select, .pan, .zoom]
  //  var selectedTool: Tool = .select

  public var modifiers: Modifiers = []

  /// Keys currently held down — drives spring-loading (e.g. Space → pan).
  /// Updated by the keyboard handler whenever a watched key is pressed/released.
  public var heldKeys: Set<KeyEquivalent> = []

  public let defaultTool: CanvasTool = .select

  public let springLoadDurationThreshold: TimeInterval = 0.15

  public init() {}
}

extension ToolHandler {
  public mutating func setTool(_ tool: CanvasTool) {
    self.selectedTool = tool
  }

  public var springLoadedTool: CanvasTool? {

    /// If any tool defines a spring-load key that is currently held,
    /// temporarily activate that tool. Prefer a tool different from the
    /// currently selected tool so we actually "spring" to something new.
    /// If multiple held keys match different tools, return the first match
    /// in allTools order.
    /// Note: Timing thresholds are not enforced here because ToolHandler
    /// doesn't track key press timestamps yet.

    /// Gather all matching tools whose springLoadKey is currently held
    let matchingTools = allTools.filter { tool in
      if let key = tool.springLoadKey {
        return heldKeys.contains(key)
      }
      return false
    }

    /// Prefer a tool different from the selected tool, if available
    if let differentFromSelected = matchingTools.first(where: { $0 != selectedTool }) {
      return differentFromSelected
    }

    // Otherwise, allow spring-loading to the selected tool itself if it matches
    return matchingTools.first
  }

  /// Behaviours that apply regardless of which tool is active.
  /// Listed in priority order — first match wins in `effectiveTool`.
  //  static let globalBehaviours: [ToolBehaviour] = [
  //    ToolBehaviour(
  //      trigger: .heldKey(.space),
  //      springLoadTarget: .pan,
  //      description: "Hold Space to temporarily pan"
  //    )
  //  ]

  //  var springLoadGlobal: [ToolBehaviour] {
  ////  var globalBehaviours: [ToolBehaviour] {
  //    allTools.map { tool in
  //      tool.
  //    }
  ////    for tool in allTools {
  ////
  ////    }
  //  }

  public var currentTool: CanvasTool { springLoadedTool ?? selectedTool }
  public var effectiveTool: CanvasTool { currentTool }

  /// True when a behaviour trigger is overriding the selected tool.
  public func isSpringLoaded(modifiers: Modifiers) -> Bool {
    currentTool != selectedTool
  }

}
