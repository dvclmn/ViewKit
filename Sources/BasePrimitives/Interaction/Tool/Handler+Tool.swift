//
//  Handler+Tool.swift
//  DrawString
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

/// ```
/// func makeOperation(controller: ToolController, state: CanvasInteractionState, modifiers: Modifiers) -> CanvasOperation {
///   CanvasOperation(
///     effectiveTool: controller.effectiveTool,
///     isSpringLoaded: controller.isSpringLoaded,
///     state: state,
///     modifiers: modifiers
///   )
/// }
/// ```

//@Observable
public struct ToolController {
  //public final class ToolController {
  private(set) public var baseTool: CanvasTool
  private(set) public var activations: [ToolActivation] = []
  public private(set) var heldKeys: Set<KeyEquivalent> = []
  public private(set) var modifiers: Modifiers = []
  public private(set) var bindings: [ToolBinding]
  public private(set) var toolRegistry: [CanvasToolKind: CanvasTool]

  public init(
    baseTool: CanvasTool = .select,
    bindings: [ToolBinding] = ToolBinding.defaultBindings(),
    tools: [CanvasTool] = CanvasTool.defaultTools
  ) {
    self.baseTool = baseTool
    self.bindings = bindings
    self.toolRegistry = Dictionary(uniqueKeysWithValues: tools.map { ($0.kind, $0) })
  }
}

extension ToolController {

  public var effectiveTool: CanvasTool {
    activations.last?.tool ?? baseTool
  }

  public var isSpringLoaded: Bool { !activations.isEmpty }

  public mutating func setBaseTool(_ tool: CanvasTool) {
    baseTool = tool
    activations.removeAll()
  }

  public mutating func setBindings(_ bindings: [ToolBinding]) {
    self.bindings = bindings
  }

  public mutating func registerTools(_ tools: [CanvasTool]) {
    self.toolRegistry = Dictionary(uniqueKeysWithValues: tools.map { ($0.kind, $0) })
  }

  public mutating func handleKeyDown(
    _ key: KeyEquivalent,
    //    modifiers: Modifiers
  ) {
    /// Track held key
    heldKeys.insert(key)

    /// Find best binding for this key/modifier pair
    guard
      let best = matchingBindings(for: key)
        .max(by: { $0.priority < $1.priority })
    else { return }

    apply(binding: best, onKeyDown: key)
  }

  public mutating func handleKeyUp(_ key: KeyEquivalent) {
    /// Stop tracking key
    heldKeys.remove(key)
    /// Remove any hold activations created by this key
    removeActivations(forKey: key)
  }

  public mutating func cancelAllSpringLoads() {
    activations.removeAll()
  }

  public mutating func updateModifiers(_ modifiers: Modifiers) {
    self.modifiers = modifiers
  }

}

// MARK: - Helpers
extension ToolController {

  private func matchingBindings(
    for key: KeyEquivalent,
    //    modifiers: Modifiers
  ) -> [ToolBinding] {
    bindings.filter { b in
      b.binding.key == key && b.binding.requiredModifiers.isSubset(of: modifiers)
    }
  }

  private mutating func apply(
    binding: ToolBinding,
    onKeyDown key: KeyEquivalent
  ) {
    let targetTool = resolveTool(for: binding.target)
    switch binding.mode {
      case .hold:
        /// Push a spring activation
//        let targetTool = tool(for: binding.target)
        let act = ToolActivation(tool: targetTool, binding: binding, key: key)
        activations.append(act)

      case .sticky:
//        let targetTool = tool(for: binding.target)
        setBaseTool(targetTool)

      case .toggle:
//        let targetTool = tool(for: binding.target)
        if effectiveTool.kind == targetTool.kind {
          /// Toggle off -> return to base (no-op if already base)
          activations.removeAll()
        } else {
          setBaseTool(targetTool)
        }
    }
  }

  private mutating func removeActivations(forKey key: KeyEquivalent) {
    /// Remove all activations created by this key (common if key repeats)
    activations.removeAll { $0.key == key && $0.binding.mode == .hold }
  }

  private func resolveTool(for kind: CanvasToolKind) -> CanvasTool {
    toolRegistry[kind] ?? baseTool
  }
}

//public struct ToolHandler {
//
//  /// Aka the Tool explicitly selected by the user, regardless of
//  /// any spring-loading and other context
//  public var selectedTool: CanvasTool = .select
//
//  public var allTools: [CanvasTool] = [.select, .pan, .zoom]
//  //  var selectedTool: Tool = .select
//
//  public var modifiers: Modifiers = []
//
//  /// Keys currently held down — drives spring-loading (e.g. Space → pan).
//  /// Updated by the keyboard handler whenever a watched key is pressed/released.
//  public var heldKeys: Set<KeyEquivalent> = []
//
//  public let defaultTool: CanvasTool = .select
//
//  public let springLoadDurationThreshold: TimeInterval = 0.15
//
//  public init() {}
//}
//
//extension ToolHandler {
//  public mutating func setTool(_ tool: CanvasTool) {
//    self.selectedTool = tool
//  }
//
//  public var springLoadedTool: CanvasTool? {
//
//    /// If any tool defines a spring-load key that is currently held,
//    /// temporarily activate that tool. Prefer a tool different from the
//    /// currently selected tool so we actually "spring" to something new.
//    /// If multiple held keys match different tools, return the first match
//    /// in allTools order.
//    /// Note: Timing thresholds are not enforced here because ToolHandler
//    /// doesn't track key press timestamps yet.
//
//    /// Gather all matching tools whose springLoadKey is currently held
//    let matchingTools = allTools.filter { tool in
//      if let key = tool.springLoadKey {
//        return heldKeys.contains(key)
//      }
//      return false
//    }
//
//    /// Prefer a tool different from the selected tool, if available
//    if let differentFromSelected = matchingTools.first(where: { $0 != selectedTool }) {
//      return differentFromSelected
//    }
//
//    // Otherwise, allow spring-loading to the selected tool itself if it matches
//    return matchingTools.first
//  }
//
//  /// Behaviours that apply regardless of which tool is active.
//  /// Listed in priority order — first match wins in `effectiveTool`.
//  //  static let globalBehaviours: [ToolBehaviour] = [
//  //    ToolBehaviour(
//  //      trigger: .heldKey(.space),
//  //      springLoadTarget: .pan,
//  //      description: "Hold Space to temporarily pan"
//  //    )
//  //  ]
//
//  //  var springLoadGlobal: [ToolBehaviour] {
//  ////  var globalBehaviours: [ToolBehaviour] {
//  //    allTools.map { tool in
//  //      tool.
//  //    }
//  ////    for tool in allTools {
//  ////
//  ////    }
//  //  }
//
//  public var currentTool: CanvasTool { springLoadedTool ?? selectedTool }
//  public var effectiveTool: CanvasTool { currentTool }
//
//  /// True when a behaviour trigger is overriding the selected tool.
//  public func isSpringLoaded(modifiers: Modifiers) -> Bool {
//    currentTool != selectedTool
//  }
//
//}

