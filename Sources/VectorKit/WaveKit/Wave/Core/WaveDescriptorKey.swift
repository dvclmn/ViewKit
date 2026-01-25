//
//  WaveDescriptorKey.swift
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
protocol OrderedWaveKey: WaveKey {
  static var order: Int { get }
}



/// A type safe way to define a `WaveDescriptor`.
/// OR, could just use ID?
/// ```
/// public enum ExampleWaveKey: WaveDescriptorKey {
///   public static let myWave = "My Wave Descriptor"
/// }
/// ```
//public protocol WaveDescriptorKey: Hashable, Sendable {
//  static var waveKey: String { get }
//}
//
//public struct WaveDescriptorID: Hashable, Sendable {
//  private let id: ObjectIdentifier
//  public let waveKey: String
//
//  public init<K: WaveDescriptorKey>(_ key: K.Type) {
//    self.id = ObjectIdentifier(key)
//    self.waveKey = key.waveKey
//  }
//}
