//
//  ConfiguredWaveKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Each wave key:
/// declares that it participates
/// declares what kind of value it carries
/// declares its default
/// ```
/// enum Fundamental: WaveKey {
///   static let defaultValue = WaveLayer(
///     wave: Wave(frequency: 1, amplitude: 1, phase: 0, waveform: .sine),
///     settings: .init(isEnabled: true)
///   )
/// }
///
/// enum Harmonic2: WaveKey {
///   static let defaultValue = WaveLayer(
///     wave: Wave(frequency: 2, amplitude: 0.3, phase: 0, waveform: .sine),
///     settings: .init(isEnabled: true)
///   )
/// }
/// ```
public protocol WaveKey {
  associatedtype Value
  static var defaultValue: Value { get }
}

/// Perhaps for later
public protocol OrderedWaveKey: WaveKey {
  static var order: Int { get }
}

/// ```
/// enum Fundamental: CodableWaveKey {
///   static let codingKey = "fundamental"
///   static let defaultValue = WaveLayer(...)
/// }
/// ```
public protocol CodableWaveKey: WaveKey where Value == ConfiguredWave {
  static var codingKey: String { get }
}

/// Usage (once, at app startup):
/// ```
/// WaveKeyRegistry.register(Fundamental.self)
/// WaveKeyRegistry.register(Harmonic2.self)
/// ```
///
/// ```
/// for (codingKey, layer) in decoded.waves {
///   if let keyType = WaveKeyRegistry.all[codingKey] {
///     stack[keyType] = layer
///   }
/// }
/// ```
//@MainActor

//@MainActor
//public enum WaveKeyRegistry: Sendable {
//  public static var all: [String: any CodableWaveKey.Type] = [:]
//
//  public static func register<K: CodableWaveKey>(_ key: K.Type) {
//    all[K.codingKey] = key
//  }
//}
