//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

/// Suitable for stacking waves together for cool effects
@dynamicMemberLookup
public struct WaveDescriptor: Identifiable, Hashable, Sendable, Codable, Equatable {
  public var id: Wave.ID { wave.id }
  public var wave: Wave
  //  public let wave: Wave
  public var config: WaveConfig

  public init(
    wave: Wave,
    config: WaveConfig = .init()
  ) {
    self.wave = wave
    self.config = config
  }

  //  public init(
  //    wave: Wave,
  //    isEnabled: Bool = true,
  //    cycles: Int = 3,
  //    sampleCount: Int = 30,
  //  ) {
  //    let config = WaveConfig(
  //      isEnabled: isEnabled,
  //      cycles: cycles,
  //      sampleCount: sampleCount
  //    )
  //    self.init(wave: wave, config: config)
  //  }
}
extension WaveDescriptor {

  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
    //    set { config[keyPath: keyPath] = newValue as! WaveConfig..SubSequence }
  }
/// Bad, don't do this
//  public func makeAnimated() -> AnimatedWave { AnimatedWave(wave: self.wave) }
}
extension WaveDescriptor {
  public static let example01: Self = .init(
    wave: .example01,
    config: .init()
  )

  public static let example02: Self = .init(
    wave: .example02,
    config: WaveConfig(cycles: 10, sampleCount: 10)
  )
}
