//
//  ConfiguredWaveKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Each wave key:
/// - declares that it participates
/// - declares what kind of value it carries
/// - declares its default
///
/// ```
/// enum Fundamental: WaveKey {
///   static let defaultValue = ConfiguredWave(
///     Wave(frequency: 1, amplitude: 1, phase: 0, waveform: .sine),
///     config: WaveConfig(isEnabled: true)
///   )
/// }
/// ```
public protocol WaveKey {
  associatedtype Value
  static var defaultValue: Value { get }
}

/// ```
/// enum Fundamental: CodableWaveKey {
///   static let codingKey = "fundamental"
///   static let defaultValue = ConfiguredWave(...)
/// }
/// ```
public protocol CodableWaveKey: WaveKey where Value == ConfiguredWave {
  static var codingKey: String { get }
}

/// Perhaps for later
public protocol OrderedWaveKey: WaveKey {
  static var order: Int { get }
}
