//
//  VisualElement+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

//public typealias ElementStore = [VisualElementKind: WaveVisualElement]

/// Base = authored value (stable, same for each sample unless you change it).
/// Current = what you render after wave offsets for this frame/sample.
///
/// That distinction matters because most wave ops are easier/safer defined against base:
/// - dotX: usually base + offset
/// - dotRadius: usually base * (1 + offset) (not “keep compounding current each channel”)
/// - dashPhase: usually base + offset (or current + offset if you want accumulating behaviour)
public struct WaveVisualElement: Sendable, Codable, Identifiable, Equatable, Hashable {
  public var id: VisualElementKind.ID { kind.id }
  public let kind: VisualElementKind

  /// Authored/stable value (e.g. the dot's baseline y for this sample)
  public var base: Double

  /// Derived value after applying wave channels for this frame/sample
  public var current: Double

  public init(kind: VisualElementKind, base: Double) {
    self.kind = kind
    self.base = base
    self.current = base
  }
}

extension WaveVisualElement {

  public mutating func resetCurrentToBase() {
    current = base
  }

  public mutating func setCurrent(_ v: Double) {
    current = kind.sanitise(v)
  }

}
