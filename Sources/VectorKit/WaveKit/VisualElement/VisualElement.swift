//
//  VisualElement+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

public typealias ElementStore = [WaveVisualElement.ElementKind: WaveVisualElement]

public struct WaveVisualElement: Sendable, Codable, Identifiable {
  public var id: ElementKind.ID { kind.id }
  public let kind: ElementKind
  
  /// a stable base (the authored value)
  public var base: Double
  
  /// a derived current (after wave offsets)
  ///
  /// channel operates on current while base stays untouched
  /// (or reset current = base each frame before applying channels).
  public var current: Double
//  public let value: Double
}
