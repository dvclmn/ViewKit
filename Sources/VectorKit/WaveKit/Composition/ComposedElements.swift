//
//  WaveDocument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation
import IdentifiedCollections

public typealias WaveElements = [WaveVisualElement.ElementKind: WaveVisualElement]
public struct WaveDocument: Codable, Sendable, Equatable {

  public var waves: IdentifiedArrayOf<ConfiguredWave>
  public var settings: WaveRenderSettings

  /// The channels define which elements are driven by which waves (and how).
  /// binds wave→element
  public var drivers: [WaveDriver]

  public init(
    waves: IdentifiedArrayOf<ConfiguredWave>,
    settings: WaveRenderSettings,
    drivers: [WaveDriver],
  ) {
    self.waves = waves
    self.settings = settings
    self.drivers = drivers
  }
}

extension WaveDocument {

  public subscript(waveID waveID: ConfiguredWave.ID) -> ConfiguredWave? {
    get { waves[id: waveID] }
    set { waves[id: waveID] = newValue }
  }

  public static func original(
    waveH: ConfiguredWave = .waveHExample,
    waveV: ConfiguredWave = .waveVExample,
    waveR: ConfiguredWave = .waveVExample,
    style: WaveStyle = .originalExample,
    sampleCount: Int = 20,
    placement: WavePlacement = .horizontal,
    interpolation: WaveInterpolation = .cubic()
  ) -> Self {
    let settings = WaveRenderSettings(
      style: style,
      blendMode: .add,
      placement: placement,
      sampleCount: sampleCount,
      interpolation: interpolation
    )

    let drivers: [WaveDriver] = [
      .dotX(with: waveV.id),
      .dotY(with: waveH.id),
      .dotRadius(with: waveR.id),
      .init(waveID: waveH.id, elementKind: .dotHue, operation: .addToBase),
    ]

    return .init(
      waves: [waveH, waveV],
      settings: settings,
      drivers: drivers,
    )
  }
}

extension ConfiguredWave {
  public static var waveHExample: Self {
    .init(
      .init(
        amp: 30,
        freq: 0.3,
        phaseTurns: 0.6,
        waveform: .sine()
      ),
      config: .init(
        cycles: 4,
        noise: 0
      )
    )
  }

  public static var waveVExample: Self {
    .init(
      .init(
        amp: 10,
        freq: 0.2,
        phaseTurns: 0,
        waveform: .sine()
      ),
      config: .init(
        cycles: 2,
        noise: 0
      )
    )
  }
}

extension WaveStyle {
  public static var originalExample: Self {
    .init(
      line: .init(
        colour: .azure,
        lineWidth: 12,
      ),
      point: .init(
        shape: .square,
        radius: 5,
        colour: .cadetblue,
        colourMixStrength: 2.0
      )
    )
  }
}
