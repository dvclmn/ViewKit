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
  public let value: Double
}
