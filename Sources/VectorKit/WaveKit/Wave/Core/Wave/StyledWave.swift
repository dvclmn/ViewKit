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
@dynamicMemberLookup
public struct StyledWave: Wavable, Hashable, Sendable, Codable, Equatable, Identifiable {
  public var id: Wave.ID { wave.id }
  public var wave: Wave
  //  public var configuredWave: ConfiguredWave
  public var config: WaveConfig
  public var style: WaveStyle

  public init(wave: Wave, config: WaveConfig, style: WaveStyle) {
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
}

extension StyledWave {
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }

  //  public var config: WaveConfig { configuredWave.config }
  public var dotRadius: CGFloat { style.pointStyle.radius }
//  public func sample(state: ContinuousParameter, at normalisedIndex: CGFloat) -> CGFloat {
//    configuredWave.sample(state: state, at: normalisedIndex)
//  }
}
