//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

/// Previously handled by now-removed `WaveModulator`
@dynamicMemberLookup
public struct ConfiguredWave: Identifiable, Hashable, Sendable, Codable, Equatable {
  public var id: Wave.ID { wave.id }
  public var wave: Wave
  public var config: WaveConfig

  public init(
    _ wave: Wave,
    config: WaveConfig = .init()
  ) {
    self.wave = wave
    self.config = config
  }
}
extension ConfiguredWave {

  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }
  /// Bad, don't do this
  //  public func makeAnimated() -> AnimatedWave { AnimatedWave(wave: self.wave) }
}
extension ConfiguredWave {
  public static let example01: Self = .init(
    .example01,
    config: .init()
  )

  public static let example02: Self = .init(
    .example02,
    config: WaveConfig(cycles: 10, sampleCount: 10)
  )
}
