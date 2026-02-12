//
//  VisualElement+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

//public typealias ElementStore = [WaveVisualElement.ElementKind: WaveVisualElement]

public struct WaveVisualElement: Sendable, Codable, Identifiable, Equatable, Hashable {
  public var id: ElementKind.ID { kind.id }
  public let kind: ElementKind
  
  /// a stable base (the authored value)
  public var base: Double
  
  /// a derived current (after wave offsets)
  /// base is stable, current is what you render.
  public var current: Double
//  public let value: Double
  
  public init(
    kind: ElementKind,
    initialValue: Double = .zero
  ) {
    self.kind = kind
    self.base = initialValue
    self.current = .zero
  }
}
