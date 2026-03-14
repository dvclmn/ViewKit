//
//  Handler+Tool.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/7/2025.
//

import SwiftUI

/// Manages tool selection, spring-loading, and key bindings.
///
/// ## Setup
///
/// ```swift
/// // 1. Create a handler with your domain's tools and bindings:
/// var toolHandler = ToolHandler(
///   baseTool: .select,
///   tools: CanvasTool.defaultTools + [.text],
///   bindings: ToolBinding.defaultBindings() + [
///     .makeToolBinding(for: .text, key: "t")
///   ]
/// )
///
/// // 2. Feed key events:
/// toolHandler.handleKeyDown("h")
/// toolHandler.handleKeyUp("h")
///
/// // 3. Read the effective tool:
/// let tool = toolHandler.effectiveTool
///
/// // 4. Get the tool list for your toolbar:
/// let tools = toolHandler.availableTools  // derived from registry + bindings
/// ```
public struct ToolHandler {
  private(set) public var baseTool: CanvasTool
  private(set) public var activations: [ToolActivation] = []
  public private(set) var heldKeys: Set<KeyEquivalent> = []
  public private(set) var modifiers: Modifiers = []
  public private(set) var bindings: [ToolBinding]
  public private(set) var toolRegistry: [CanvasToolKind: CanvasTool]

  public init(
    baseTool: CanvasTool = .select,
    tools: [CanvasTool] = CanvasTool.defaultTools,
    bindings: [ToolBinding] = ToolBinding.defaultBindings()
  ) {
    self.baseTool = baseTool
    self.bindings = bindings
    self.toolRegistry = Dictionary(uniqueKeysWithValues: tools.map { ($0.kind, $0) })
  }
}

extension ToolHandler {

  /// All registered tools, ordered by binding appearance then remaining registry entries.
  ///
  /// Use this to populate toolbar UI — no separate `ToolSetup` needed.
  public var availableTools: [CanvasTool] {
    var seen: Set<CanvasToolKind> = []
    var result: [CanvasTool] = []

    /// Tools referenced by bindings, in binding order.
    for binding in bindings {
      guard !seen.contains(binding.target),
        let tool = toolRegistry[binding.target]
      else { continue }
      seen.insert(binding.target)
      result.append(tool)
    }

    /// Remaining registered tools not covered by any binding.
    for (kind, tool) in toolRegistry where !seen.contains(kind) {
      result.append(tool)
    }

    return result
  }
}

extension ToolHandler {

  public var effectiveTool: CanvasTool {
    activations.last?.tool ?? baseTool
  }

//  public var canvasModifierPolicy: CanvasPolicy {
//
//    CanvasPolicy(fromOperation: operation, tool: store.toolHandler.effectiveTool)
//
//
//  }

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

  public mutating func handleKeyDown(_ key: KeyEquivalent) {
    heldKeys.insert(key)

    guard
      let best = matchingBindings(for: key)
        .max(by: { $0.priority < $1.priority })
    else { return }

    apply(binding: best, onKeyDown: key)
  }

  public mutating func handleKeyUp(_ key: KeyEquivalent) {
    heldKeys.remove(key)
    removeActivations(forKey: key)
  }

  public mutating func cancelAllSpringLoads() {
    activations.removeAll()
  }

  public mutating func updateModifiers(_ modifiers: Modifiers) {
    self.modifiers = modifiers
  }

  /// Returns the first shortcut key bound to the given tool kind, if any.
  ///
  /// Useful for displaying keyboard shortcuts in menus and tooltips.
  public func shortcutKey(for kind: CanvasToolKind) -> KeyEquivalent? {
    bindings.first { $0.target == kind && $0.mode == .sticky }?.binding.key
  }
}

// MARK: - Helpers
extension ToolHandler {

  private func matchingBindings(for key: KeyEquivalent) -> [ToolBinding] {
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
        let act = ToolActivation(tool: targetTool, binding: binding, key: key)
        activations.append(act)

      case .sticky:
        setBaseTool(targetTool)

      case .toggle:
        if effectiveTool.kind == targetTool.kind {
          activations.removeAll()
        } else {
          setBaseTool(targetTool)
        }
    }
  }

  private mutating func removeActivations(forKey key: KeyEquivalent) {
    activations.removeAll { $0.key == key && $0.binding.mode == .hold }
  }

  private func resolveTool(for kind: CanvasToolKind) -> CanvasTool {
    toolRegistry[kind] ?? baseTool
  }
}
