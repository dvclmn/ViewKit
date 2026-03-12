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
  var selectedTool: CanvasTool = .select
  
  var allTools: [CanvasTool] = [.select, .pan, .zoom]
//  var selectedTool: Tool = .select

  var modifiers: Modifiers = []

  /// Keys currently held down — drives spring-loading (e.g. Space → pan).
  /// Updated by the keyboard handler whenever a watched key is pressed/released.
  var heldKeys: Set<KeyEquivalent> = []

  let defaultTool: CanvasTool = .select
  
  let springLoadDurationThreshold: TimeInterval = 0.15
}

extension ToolHandler {
  mutating func setTool(_ tool: CanvasTool) {
    self.selectedTool = tool
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

  var springLoadedTool: CanvasTool? {

//    let globalBehaviours
    
//    let allBehaviours = Self.globalBehaviours + selectedTool.behaviours

    for behaviour in allBehaviours {
      switch currentTool {
//        case .modifierKey(let required) where modifiers.contains(required):
//          return behaviour.springLoadTarget
//        case .heldKey(let key) where heldKeys.contains(key):
//          return behaviour.springLoadTarget
//        default:
//          break
      }
//    }
//    return nil
  }

  var currentTool: Tool { springLoadedTool ?? selectedTool }
  var effectiveTool: Tool { currentTool }

  /// True when a behaviour trigger is overriding the selected tool.
  func isSpringLoaded(modifiers: Modifiers) -> Bool {
    currentTool != selectedTool
  }

  var shouldShowCharacterPreview: Bool {
    currentTool == .select || currentTool == .text
  }

}
