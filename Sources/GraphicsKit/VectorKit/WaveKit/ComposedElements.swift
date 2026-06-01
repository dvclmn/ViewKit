//
//  WaveDocument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation
import CoreTools
import ViewTools
import BaseTools
import ColourTools

//import IdentifiedCollections

public typealias WaveElements = [VisualElementKind: WaveVisualElement]
public struct WaveDocument: Codable, Sendable, Equatable {

  public var waves: IdentifiedList<ConfiguredWave>
  public var settings: WaveRenderSettings

  /// The channels define which elements are driven by which waves (and how).
  /// binds wave→element
  public var drivers: [WaveDriver]

  public init(
    waves: IdentifiedList<ConfiguredWave>,
    settings: WaveRenderSettings,
    drivers: [WaveDriver]
  ) {
    self.waves = waves
    self.settings = settings
    self.drivers = drivers
  }

  /// Convenience initializer to allow passing a plain array.
  public init(
    waves: [ConfiguredWave],
    settings: WaveRenderSettings,
    drivers: [WaveDriver]
  ) {
    self.init(waves: IdentifiedList(waves), settings: settings, drivers: drivers)
  }
}

extension WaveDocument {
  public mutating func addElement(
    _ kind: VisualElementKind,
    baseValue: Double? = nil,
    with wave: ConfiguredWave = .waveHExample
  ) {
    //    let element = WaveVisualElement(
    //      kind: kind,
    //      base: baseValue ?? .zero
    //    )
    let newDriver = WaveDriver(
      waveID: wave.id,
      elementKind: kind,
      operation: kind.operation
    )
    waves.append(wave)
    drivers.append(newDriver)
  }
  public subscript(waveID waveID: ConfiguredWave.ID) -> ConfiguredWave? {
    get { waves[id: waveID] }
    set { waves[id: waveID] = newValue }
  }

  public subscript(element elementKind: VisualElementKind) -> ConfiguredWave.ID? {
    get {
      let driver = drivers.first { driver in
        driver.elementKind == elementKind
      }
      return driver?.waveID
    }
  }

  public static func original(
    waveH: ConfiguredWave = .waveHExample,
    waveV: ConfiguredWave = .waveVExample,
    waveR: ConfiguredWave = .waveRExample,
    style: WaveStyle = .originalExample,
    sampleCount: Int = 20,
    placement: WavePlacement = .vertical,
    interpolation: WaveInterpolation = .linear
  ) -> Self {
    let settings = WaveRenderSettings(
      style: style,
      blendMode: .add,
      placement: placement,
      sampleCount: sampleCount,
      interpolation: interpolation
    )

    let drivers: [WaveDriver] = [
      .make(.dotX, waveID: waveV.id),
      .make(.dotY, waveID: waveH.id),
      .make(.dotRadius, waveID: waveR.id),
      .make(.dotHue, waveID: waveV.id),
    ]

    return .init(
      waves: IdentifiedList([waveH, waveV, waveR]),
      settings: settings,
      drivers: drivers,
    )
  }
}

extension ConfiguredWave {
  public static var waveHExample: Self {
    .init(
      .init(
        amp: 100,
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
        amp: 80,
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

  public static var waveRExample: Self {
    .init(
      .init(
        amp: 0.5,
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
        colour: .forestgreen,
        lineWidth: 22,
      ),
      point: .init(
        shape: .circle,
        radius: 30,
        colour: RGBColour(0.3, 0.9, 0.3),
        colourMixStrength: 3.4
      )
    )
  }
}
