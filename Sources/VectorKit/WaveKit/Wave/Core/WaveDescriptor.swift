//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

//extension BreathingWave {
//
//  struct SubWave {
//    let isEnabled: Bool
//
//  }
//}

//struct  {
//  let wave: Wave
////  let lineStyle: LineStyle
////  let pointStyle: PointStyle
//  let cycles: Int
//
//}

/// A type safe way to define a `WaveDescriptor`.
/// OR, could just use ID?
/// ```
/// public enum ExampleWaveKey: WaveDescriptorKey {
///   public static let key = "My Wave Descriptor"
/// }
/// ```
public protocol WaveDescriptorKey: Hashable, Sendable {
  static var key: String { get }
}

/// Suitable for stacking waves together for cool effects
public struct WaveDescriptor: Identifiable, Hashable, Sendable, Codable {

  public var id: Wave.ID { wave.id }
  let wave: Wave
  let config: WaveConfig
  
  public init(
    wave: Wave,
    config: WaveConfig = .init()
  ) {
    self.wave = wave
    self.config = config
//    self.isEnabled = isEnabled
//    self.cycles = cycles
//    self.sampleCount = sampleCount
  }
  
  public init(
    wave: Wave,
    isEnabled: Bool = true,
    cycles: Int = 3,
    sampleCount: Int = 30,
  ) {
    let config = WaveConfig(
      isEnabled: isEnabled,
      cycles: cycles,
      sampleCount: sampleCount
    )
    self.init(wave: wave, config: config)
  }
}

public struct WaveConfig: Hashable, Sendable, Codable {
  let isEnabled: Bool
  let cycles: Int
  let sampleCount: Int
  
  public init(
    isEnabled: Bool = true,
    cycles: Int = 3,
    sampleCount: Int = 30,
  ) {
    self.isEnabled = isEnabled
    self.cycles = cycles
    self.sampleCount = sampleCount
  }
}
