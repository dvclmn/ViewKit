//
//  WaveChannel.swift
//  BaseDemos
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import Foundation
import VectorKit

/// What do `WaveVisualElement`s need, to be be animated appropriately?

/// Perhaps create a composition that can be spun up at run time?
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
  public let compose: (_ state: inout WaveVisualElement, _ offset: Double) -> Void
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
