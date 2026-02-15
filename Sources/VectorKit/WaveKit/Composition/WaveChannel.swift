//
//  WaveDriver.swift
//  BaseDemos
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import Foundation

public struct WaveDriver: Sendable, Codable, Equatable, Identifiable {

  public let id: UUID
  public var waveID: ConfiguredWave.ID

  /// The element being animated by the wave
  public let elementKind: VisualElementKind

  /// The channel promises: “I’ll fetch the Double for you, you just mutate it.”
  public var operation: WaveOperation

  public init(
    id: UUID = UUID(),
    waveID: ConfiguredWave.ID,
    elementKind: VisualElementKind,
    operation: WaveOperation
  ) {
    self.id = id
    self.waveID = waveID
    self.elementKind = elementKind
    self.operation = operation
  }
}

extension WaveDriver {

  public static func make(
    _ element: VisualElementKind,
    waveID: ConfiguredWave.ID,
    //    operation: WaveOperation? = nil
    //    operation: @autoclosure @escaping () -> WaveOperation
  ) -> Self {
    let op = element.operation
    return Self(waveID: waveID, elementKind: element, operation: op)
    //    let op = element.operation(override: operation)
  }

  /// Applies this channel to `element` if it targets the same kind.
  @inlinable
  public func applyOperation(
    to element: inout WaveVisualElement,
    offset: Double
  ) {
    guard element.kind == elementKind else { return }
    
    let value = operation.apply(
      base: element.base,
      current: element.current,
      offset: offset
    )
    element.setCurrent(value)
  }
}

extension Array where Element == WaveDriver {
  public subscript(waveID: ConfiguredWave.ID) -> VisualElementKind? {
    first { $0.waveID == waveID }?.elementKind
  }

  @inlinable
  public func applyAll(to element: inout WaveVisualElement, offset: Double) {
    for ch in self { ch.applyOperation(to: &element, offset: offset) }
  }

}
