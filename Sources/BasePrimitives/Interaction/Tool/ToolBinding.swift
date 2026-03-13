//
//  ToolBinding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

public struct ToolBinding: Hashable, Sendable {
  public let scope: BindingScope
  public let binding: KeyBinding
  public let target: CanvasToolKind
  public let mode: ActivationMode
  public let priority: Int

  public init(
    scope: BindingScope,
    binding: KeyBinding,
    target: CanvasToolKind,
    mode: ActivationMode,
    priority: Int = 0
  ) {
    self.scope = scope
    self.binding = binding
    self.target = target
    self.mode = mode
    self.priority = priority
  }
}

extension ToolBinding {
  /// A minimal set of sensible defaults:
  /// - Sticky shortcuts for Select (V), Pan (H), Zoom (Z)
  /// - Global hold Space => Pan with a higher priority
  public static func defaultBindings() -> [ToolBinding] {

    var bindings: [ToolBinding] = []

    bindings.append(
      ToolBinding(
        scope: .toolSpecific(.select),
        binding: KeyBinding(key: "v"),
        target: .select,
        mode: .sticky,
        priority: 10))

    bindings.append(
      ToolBinding(
        scope: .toolSpecific(.pan),
        binding: KeyBinding(key: "h"),
        target: .pan,
        mode: .sticky,
        priority: 10))

    bindings.append(
      ToolBinding(
        scope: .toolSpecific(.zoom),
        binding: KeyBinding(key: "z"),
        target: .zoom,
        mode: .sticky,
        priority: 10))

    /// Global Space -> Pan (hold), higher priority so it wins over others when held
    bindings.append(
      ToolBinding(
        scope: .global,
        binding: KeyBinding(key: .space),
        target: .pan,
        mode: .hold,
        priority: 100))
    return bindings
  }
}
