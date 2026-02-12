//
//  Model+WaveComposition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/8/2025.
//

import Foundation

public struct ComposedElements: Codable, Sendable, Equatable {
  public var waveComposition: WaveComposition

  /// The channels define which elements are driven by which waves (and how).
  public var channels: [WaveChannel]

  /// Author-time elements (for the *sample*). You can treat these as defaults/prototypes.
  /// Why prototypes and not [WaveVisualElement]?
  /// Because your per-sample dotY base etc changes with index (baseY), and you don’t want to
  /// persist 200 elements for every sample unless you really mean to. Store defaults,
  /// then build per-sample elements cheaply.
  public var elementPrototypes: [WaveVisualElement.ElementKind: Double]

  public init(
    waveComposition: WaveComposition,
    channels: [WaveChannel],
    elementPrototypes: [WaveVisualElement.ElementKind: Double]
  ) {
    self.waveComposition = waveComposition
    self.channels = channels
    self.elementPrototypes = elementPrototypes
  }
}

/// Ha need to fix these naaaames
//public struct ComposedElements: Codable, Sendable, Equatable {
//  public var waveComposition: WaveComposition
//  public var elements: [WaveVisualElement]
//  //  public var elements: ElementStore
//
//  public init(
//    waveComposition: WaveComposition,
//    elements: [WaveVisualElement]
//      //    elements: ElementStore
//  ) {
//    self.waveComposition = waveComposition
//    self.elements = elements
//  }
//}
//
//extension ComposedElements {
//  public func thing() {
//    let channels: [WaveChannel] = [
//      .dotHorizontal(with: <#T##ConfiguredWave#>)
//    ]
//  }
//}

/// Let's set up some initial elements just to play
extension ComposedElements {
  public static let example: ComposedElements = .init(
    waveComposition: .example,
    elements: [
      WaveVisualElement(
        kind: .dotRadius,
        initialValue: 2.0,
      ),
      WaveVisualElement(kind: .dotX),
      WaveVisualElement(kind: .dotY),
    ]
  )

}

public struct WaveComposition: Sendable, Codable, Equatable {
  //  public var channels: [WaveChannel]
  public var waves: [ConfiguredWave]

  public var style: WaveStyle

  public var blendMode: WaveBlendMode
  public var placement: WavePlacement
  public var sampleCount: Int
  public var interpolation: WaveInterpolation

  public init(
    waves: [ConfiguredWave],
    //    channels: [WaveChannel],
    blendMode: WaveBlendMode = .add,
    style: WaveStyle = .init(),
    placement: WavePlacement = .vertical,
    sampleCount: Int = 20,
    interpolation: WaveInterpolation = .linear
  ) {
    self.waves = waves
    self.blendMode = blendMode
    self.style = style
    self.placement = placement
    self.sampleCount = sampleCount
    self.interpolation = interpolation
  }
}

extension WaveComposition {
  public static let example: WaveComposition = .init(
    waves: [
      ConfiguredWave(
        Wave<Double>(amp: 2.0, freq: 1.0, phase: 0.0),
        config: WaveConfig(cycles: 2.0, noise: 0.0)
      )
    ],
    blendMode: .add,
    style: WaveStyle(),
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
