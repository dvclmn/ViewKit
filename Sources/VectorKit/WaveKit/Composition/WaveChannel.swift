//
//  WaveChannel.swift
//  BaseDemos
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import Foundation
import MetaCodable

public typealias WaveComposer =
  @Sendable (
    _ base: Double,
    _ current: Double,
    _ offset: Double
  ) -> Double
//public typealias WaveComposer = (_ element: inout WaveVisualElement, _ offset: Double) -> Void
//public typealias WaveComposer = @Sendable (_ value: Double, _ offset: Double) -> Double
//public typealias WaveComposer = (_ elementValue: inout Double, _ offset: Double) -> Void

/// Perhaps create a composition that can be spun up at run time?
/// This isn't a persisted thing, it's just a builder or a factory, i think
public struct WaveChannel: Sendable {
  /// So for wave stack, now instead of registering a very specific named one,
  /// we just make a new more run-time-y one?
  public var wave: ConfiguredWave

  /// The element being animated by the wave
  public let elementKind: WaveVisualElement.ElementKind
  //  public let element: WaveVisualElement.Meta

  /// This gives a visual element the actual values, based on the provided
  /// offset, to be moved around interestingly on the Canvas
  /// The closure allows the caller to express *how* the offset should be
  /// applied to a particular element
  //  public let compose: (_ element: inout WaveVisualElement, _ offset: Double) -> Void

  /// The channel promises: “I’ll fetch the Double for you, you just mutate it.”
  //  @IgnoreCoding
  public let compose: WaveComposer

  public init(
    wave: ConfiguredWave,
    elementKind: WaveVisualElement.ElementKind,
    compose: @escaping WaveComposer
  ) {
    self.wave = wave
    self.elementKind = elementKind
    self.compose = compose
  }
}

extension WaveChannel {

  /// Returns a new element with this channel applied at the given offset.
  /// This is the non-mutating counterpart to `apply(to:offset:)` and includes sanitisation.
  public func applying(
    to element: WaveVisualElement,
    offset: Double,
    //    compose: WaveComposer
  ) -> WaveVisualElement {
    /// If this channel doesn't target the element's kind, return the element unchanged
    guard element.kind == elementKind else { return element }

    /// Compose a new value from the current value and offset, then sanitise it
    //    let newValue = compose(element.value, offset)
    //    let sanitised = element.kind.sanitise(newValue)
    let newCurrent = element.kind.sanitise(
      compose(element.base, element.current, offset)
    )
    var newElement = WaveVisualElement(kind: element.kind, initialValue: element.base)
    newElement.updateCurrent(with: newCurrent)
    
    return newElement
    //    return .init(kind: element.kind, base: element.base, current: newCurrent)
    //    return .init(kind: element.kind, value: sanitised)
  }
}

/// ```
/// elements = elements
///   .map { $0.resettingCurrentToBase() }
///   .map { channels.applyingAll(to: $0, offset: offset) }
///   ```
extension Sequence where Element == WaveChannel {

  public subscript(elementKind: WaveVisualElement.ElementKind) -> WaveChannel? {
    first { $0.elementKind == elementKind }
  }

  public func applyingAll(to element: WaveVisualElement, offset: Double) -> WaveVisualElement {
    reduce(element) {
      partial,
      channel in
      channel.applying(to: partial, offset: offset)
    }
  }
}

//  public func apply(to element: inout WaveVisualElement, offset: Double) {
//    guard element.kind == elementKind else { return }
//    compose(&element.value, offset)
//    element.value = element.kind.sanitise(element.value)
//  }

//  public func applying(to element: WaveVisualElement, offset: Double) -> WaveVisualElement {
//    guard element.kind == elementKind else { return element }
//    let new = compose(element.value, offset)
//    let sanitised = element.kind.sanitise(element.value)
//    return .init(kind: element.kind, value: compose(element.value, offset))
//  }

//  public func apply(
//    to element: inout WaveVisualElement,
//    offset: Double
//  ) {
////    let path = self.element.doubleCase
////    guard var value = element[case: path] else { return }
//    compose(&element, offset)
//    element
////    element[case: path] = value
//  }
//}

//extension Array where Element == WaveChannel {
//}

/// This is just a slightly convulated way to get a wave from a wave stack,
/// so will probably remove
//struct WaveChannelLegacy {
//  //  let target: TargetWaveProperty
//  let wave: ConfiguredWave
//  let compose: (_ state: inout SampleState, _ offset: Double) -> Void
//}
//
//extension WaveChannelLegacy {
//  func timePhase(from elapsed: TimeInterval) -> Double {
//    twoPi() * wave.frequency * elapsed
//  }
//}

//extension WaveChannelLegacy {
//  static func originalWaves(
//    waveH: ConfiguredWave,
//    waveV: ConfiguredWave,
//    waveR: ConfiguredWave,
//  ) -> [WaveChannelLegacy] {
//    [
//      WaveChannelLegacy(
//        target: .horizontal,
//        wave: waveH,
//        compose: { state, offset in
//          state.y += offset
//        }
//      ),
//      WaveChannelLegacy(
//        target: .vertical,
//        wave: waveV,
//        compose: { state, offset in
//          state.x += offset
//        }
//      ),
//      WaveChannelLegacy(
//        target: .radius,
//        wave: waveR,
//        compose: { state, offset in
//          state.radius = max(0, state.radius * (1 + offset))
//        }
//      ),
//    ]
//  }
//}
