//
//  WaveConfiguration.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/8/2025.
//

import Foundation
import IdentifiedCollections

public struct WaveConfiguration: Sendable, Codable, Equatable {
  
  public var style: WaveStyle
  public var blendMode: WaveBlendMode
  public var placement: WavePlacement
  public var sampleCount: Int
  public var interpolation: WaveInterpolation

  public init(
//    waves: IdentifiedArrayOf<ConfiguredWave>,
    style: WaveStyle = .init(),
    blendMode: WaveBlendMode = .add,
    placement: WavePlacement = .vertical,
    sampleCount: Int = 20,
    interpolation: WaveInterpolation = .linear
  ) {
//    self.waves = waves
    self.style = style
    self.blendMode = blendMode
    self.placement = placement
    self.sampleCount = sampleCount
    self.interpolation = interpolation
  }
}

extension WaveConfiguration {
//  public subscript(waveID waveID: ConfiguredWave.ID) -> ConfiguredWave? {
//    get { waves[id: waveID] }
//    set { waves[id: waveID] = newValue }
//  }

  public static let example: WaveConfiguration = .init(
//    waves: [
//      ConfiguredWave(
//        Wave<Double>(
//          amp: 2.0,
//          freq: 1.0,
//          phaseTurns: 0.0,
//          waveform: .sineDefault
//        ),
//        config: WaveConfig(cycles: 2.0, noise: 0.0)
//      )
//    ],
    style: WaveStyle(),
    blendMode: .add,
    placement: .vertical,
    sampleCount: 30,
    interpolation: .cubic()
  )
}

/// Encapsulates the “how do these waves combine?” logic.
/// Simply has the ability to take in 2 or more Waves, and
/// create a combined/single Composition.
//public struct WaveComposition<T: WaveFloat>: Sendable, Codable {
//  var waves: [FloatWave.ID]
//  var mode: WaveBlendMode
//
//  public init(
//    waves: [FloatWave.ID] = [],
//    mode: WaveBlendMode = .add
//  ) {
//    self.waves = waves
//    self.mode = mode
//  }
//}

//extension WaveComposition {
//
//  public static var empty: WaveComposition { .init() }

//  public func wavesForEffect(from library: [FloatWave]) -> [FloatWave] {
//    //    let ws = waves.compactMap { id in library.first { $0.id == id } }
//    //    let waveLibrary = Dictionary(uniqueKeysWithValues: library.map { ($0.id, $0) })
//    //    return waves.compactMap { ws[$0] }
//
//    let waveLibrary = Dictionary(uniqueKeysWithValues: library.map { ($0.id, $0) })
//    return waves.compactMap { waveLibrary[$0] }
//  }

//  public func value(
//    elapsed: T,
//    waveLibrary library: [FloatWave]
//  ) -> T {
//
//    //    let wavesForEffect = wavesForEffect(from: library)
//    //    let waveValues: [CGFloat] = wavesForEffect.map { wave in
//    //      wave.value(elapsed: elapsed)
//    //    }
//
//    let ws = waves.compactMap { id in library.first { $0.id == id } }
//    let waveValues = ws.map { $0.waveform.sample(phase: elapsed) }
//
//    /// Handle empty case
//    guard !waveValues.isEmpty else { return 0 }
//
//    /// Blend according to mode
//    return switch mode {
//      case .add: waveValues.reduce(0, +)
//      case .multiply: waveValues.reduce(1, *)
//      case .max: waveValues.max() ?? 0
//      case .min: waveValues.min() ?? 0
//    }
//  }
//}
