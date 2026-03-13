//
//  ToolBinding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

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

  public static func makeToolBinding(
    for kind: CanvasToolKind,
    key: KeyEquivalent,
    //    scope: BindingScope.Meta,
    mode: ActivationMode = .sticky,
    priority: Int = 10
  ) -> Self {
    .init(
      scope: .tool(kind),
      binding: .init(key: key),
      target: kind,
      mode: mode,
      priority: priority
    )
  }

  public static func makeGlobalBinding(
    for kind: CanvasToolKind,
    key: KeyEquivalent,
    mode: ActivationMode = .hold,
    priority: Int = 100
  ) -> Self {
    .init(
      scope: .global,
      binding: .init(key: key),
      target: kind,
      mode: mode,
      priority: priority
    )
  }

  /// A minimal set of sensible defaults:
  /// - Sticky shortcuts for Select (V), Pan (H), Zoom (Z)
  /// - Global hold Space => Pan with a higher priority
  public static func defaultBindings() -> [ToolBinding] {
    [
      makeToolBinding(for: .select, key: "v"),
      makeToolBinding(for: .pan, key: "h"),
      makeToolBinding(for: .zoom, key: "z"),
      makeGlobalBinding(for: .pan, key: .space),
    ]
    //    var bindings: [ToolBinding] = []
    //
    //    bindings.append(
    //      ToolBinding(
    //        scope: .tool(.select),
    //        binding: KeyBinding(key: "v"),
    //        target: .select,
    //        mode: .sticky,
    //        priority: 10))
    //
    //    bindings.append(
    //      ToolBinding(
    //        scope: .tool(.pan),
    //        binding: KeyBinding(key: "h"),
    //        target: .pan,
    //        mode: .sticky,
    //        priority: 10))
    //
    //    bindings.append(
    //      ToolBinding(
    //        scope: .tool(.zoom),
    //        binding: KeyBinding(key: "z"),
    //        target: .zoom,
    //        mode: .sticky,
    //        priority: 10))
    //
    //    /// Global Space -> Pan (hold), higher priority so it wins over others when held
    //    bindings.append(
    //      ToolBinding(
    //        scope: .global,
    //        binding: KeyBinding(key: .space),
    //        target: .pan,
    //        mode: .hold,
    //        priority: 100))
    //    return bindings
  }
}
