//
//  StyledWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import Foundation

/// A convenience for applying a single style to a single ``Wave``.
/// If applying a ``WaveStyle`` to *multiple* Waves, prefer holding an instance
/// of `WaveStyle` alongside the Waves, rather than using this type.
public struct StyledWave: Wavable, Hashable, Codable, Equatable, Identifiable {
  public typealias Value = Float
  
  public var id: Wave<Value>.ID { wave.id }
  public var wave: Wave<Value>
  public var config: WaveConfig<Value>
  public var style: WaveStyle

  public init(_ wave: Wave<Value>, config: WaveConfig<Value>, style: WaveStyle) {
    self.wave = wave
    self.config = config
    self.style = style
  }
}

extension StyledWave {
  public init(configuredWave: ConfiguredWave, style: WaveStyle) {
    self.wave = configuredWave.wave
    self.config = configuredWave.config
    self.style = style
  }
  
  public var configuredWave: ConfiguredWave { .init(wave, config: config) }
  public var dotRadius: Value { style.pointStyle.radius }
  public var lineWidth: Value { style.lineStyle.lineWidth }
}
