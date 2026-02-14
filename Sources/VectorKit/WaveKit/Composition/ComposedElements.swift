//
//  WaveDocument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation
import IdentifiedCollections

public struct WaveDocument: Codable, Sendable, Equatable {

  public var waves: IdentifiedArrayOf<ConfiguredWave>

  public var config: WaveConfiguration

  /// The channels define which elements are driven by which waves (and how).
  /// binds wave→element
  public var drivers: [WaveDriver]

  /// These are like blueprints/templates
  /// Author-time elements (for the *sample*). You can treat these as defaults/prototypes.
  /// Prototypes define base values used to instantiate per-sample elements
//  public var elementDefaults: [WaveVisualElement.ElementKind: Double]

  public init(
    waves: IdentifiedArrayOf<ConfiguredWave>,
    config: WaveConfiguration,
    drivers: [WaveDriver],
//    elementDefaults: [WaveVisualElement.ElementKind: Double]
  ) {
    self.waves = waves
    self.config = config
    self.drivers = drivers
//    self.elementDefaults = elementDefaults
  }
}

extension WaveDocument {
  
  public subscript(waveID waveID: ConfiguredWave.ID) -> ConfiguredWave? {
    get { waves[id: waveID] }
    set { waves[id: waveID] = newValue }
  }
  
//  public static func create(
//    waves: ConfiguredWave...,
////    waveH: ConfiguredWave = .init(Wave<Double>.example02),
////    waveV: ConfiguredWave = .init(Wave<Double>.example02),
//    //    waveR: ConfiguredWave = .init(Wave<Double>.example02),
//    style: WaveStyle = .init(line: .init(lineWidth: 30)),
//    sampleCount: Int = 20,
//    interpolation: WaveInterpolation = .cubic()
//  ) -> Self {
//    let composition = WaveConfiguration(
//      waves: [waveH, waveV],
//      //      waves: [waveH, waveV, waveR],
//      style: style,
//      blendMode: .add,  // whatever your enum is
//      placement: .vertical,  // placeholder
//      sampleCount: sampleCount,
//      interpolation: interpolation
//    )
//    
//    let drivers: [WaveDriver] = [
//      .dotX(with: waveV.id),  // vertical wave affects X (as you had)
//      .dotY(with: waveH.id),  // horizontal wave affects Y (as you had)
//      //      .dotRadius(with: waveR.id),
//      //      .init(waveID: waveV.id, elementKind: .dotHue, operation: .addToBase)
//    ]
//    
//    //    let prototypes: [WaveVisualElement.ElementKind: Double] = [
//    //      .dotX: 0,
//    //      .dotY: 0,
//    //      .dotRadius: style.pointStyle.radius,
//    //      .dashPhase: style.lineStyle.dashPhase,
//    //      .lineWidth: style.lineStyle.lineWidth,
//    //    ]
//    
//    return .init(
//      library: composition,
//      drivers: drivers,
//    //      elementDefaults: prototypes
//    )
//  }



  public static func original(
    waveH: ConfiguredWave = .init(Wave<Double>.example02),
    waveV: ConfiguredWave = .init(Wave<Double>.example02),
//    waveR: ConfiguredWave = .init(Wave<Double>.example02),
    style: WaveStyle = .init(line: .init(lineWidth: 30)),
    sampleCount: Int = 20,
    interpolation: WaveInterpolation = .cubic()
  ) -> Self {
    let composition = WaveConfiguration(
      waves: [waveH, waveV],
//      waves: [waveH, waveV, waveR],
      style: style,
      blendMode: .add,  // whatever your enum is
      placement: .vertical,  // placeholder
      sampleCount: sampleCount,
      interpolation: interpolation
    )

    let drivers: [WaveDriver] = [
      .dotX(with: waveV.id),  // vertical wave affects X (as you had)
      .dotY(with: waveH.id),  // horizontal wave affects Y (as you had)
//      .dotRadius(with: waveR.id),
      //      .init(waveID: waveV.id, elementKind: .dotHue, operation: .addToBase)
    ]

//    let prototypes: [WaveVisualElement.ElementKind: Double] = [
//      .dotX: 0,
//      .dotY: 0,
//      .dotRadius: style.pointStyle.radius,
//      .dashPhase: style.lineStyle.dashPhase,
//      .lineWidth: style.lineStyle.lineWidth,
//    ]

    return .init(
      library: composition,
      drivers: drivers,
//      elementDefaults: prototypes
    )
  }
}
