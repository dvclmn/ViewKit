//
//  WaveChannel.swift
//  BaseDemos
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import Foundation

public typealias WaveComposer = (_ value: inout Double, _ offset: Double) -> Void

/// Perhaps create a composition that can be spun up at run time?
/// A grouping of `WaveChannels` is a ``WaveComposition``
public struct WaveChannel {
  /// So for wave stack, now instead of registering a very specific named one,
  /// we just make a new more run-time-y one?
  public var wave: ConfiguredWave

  /// The element being animated by the wave
  public let element: WaveVisualElement.Meta

  /// This gives a visual element the actual values, based on the provided
  /// offset, to be moved around interestingly on the Canvas
  /// The closure allows the caller to express *how* the offset should be
  /// applied to a particular element
  //  public let compose: (_ element: inout WaveVisualElement, _ offset: Double) -> Void

  /// The channel promises: “I’ll fetch the Double for you, you just mutate it.”
  public let compose: WaveComposer

  public init(
    wave: ConfiguredWave,
    element: WaveVisualElement.Meta,
    compose: @escaping WaveComposer
  ) {
    self.wave = wave
    self.element = element
    self.compose = compose
  }
}

extension WaveChannel {
  /// Applies this channel to a concrete element instance.
  public func apply(to element: inout WaveVisualElement, offset: Double) {
    let path = self.element.doubleCase
    guard var value = element[case: path] else { return }
    compose(&value, offset)
    element[case: path] = value
  }
}

extension Array where Element == WaveChannel {
  public subscript(element: WaveVisualElement.Meta) -> WaveChannel? {
    first { $0.element == element }
  }
}

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
