//
//  ConfiguredWaveKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// ```
/// enum DotRadiusWave: WaveKey {
///   static let defaultValue = ConfiguredWave(
///     Wave(freq: 1, amp: 1, phase: 0, waveform: .sine),
///     config: WaveConfig(isEnabled: true)
///   )
/// }
/// ```
public protocol WaveKey: Hashable, Sendable {
  static var codingKey: String { get }
  static var displayName: String { get }
  static var defaultValue: ConfiguredWave { get }
}

/// Perhaps for later
public protocol OrderedWaveKey: WaveKey {
  static var order: Int { get }
}
