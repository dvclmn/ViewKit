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
public struct StyledWave {
  public var wave: ConfiguredWave
  public var style: WaveStyle

  public init(wave: ConfiguredWave, style: WaveStyle) {
    self.wave = wave
    self.style = style
  }
}

extension StyledWave {
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave, T>) -> T {
    get { self.wave.wave[keyPath: keyPath] }
    set { self.wave.wave[keyPath: keyPath] = newValue }
  }
  
  public init(
    wave: Wave,
    config: WaveConfig,
    style: WaveStyle
  ) {
    self.wave = ConfiguredWave(wave, config: config)
    self.style = style
  }

  public var config: WaveConfig { wave.config }
  public var dotRadius: CGFloat { style.pointStyle.radius }
  public func sample(state: ContinuousParameter, at normalisedIndex: CGFloat) -> CGFloat {
    wave.sample(state: state, at: normalisedIndex)
  }
}
