//
//  WaveDescriptorKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// A type safe way to define a `WaveDescriptor`.
/// OR, could just use ID?
/// ```
/// public enum ExampleWaveKey: WaveDescriptorKey {
///   public static let myWave = "My Wave Descriptor"
/// }
/// ```
public protocol WaveDescriptorKey: Hashable, Sendable {
  static var waveKey: String { get }
}

public struct WaveDescriptorID: Hashable, Sendable {
  private let id: ObjectIdentifier
  public let waveKey: String

  public init<K: WaveDescriptorKey>(_ key: K.Type) {
    self.id = ObjectIdentifier(key)
    self.waveKey = key.waveKey
  }

  //  public static func == (lhs: Self, rhs: Self) -> Bool {
  //    lhs.id == rhs.id
  //  }
  //
  //  public func hash(into hasher: inout Hasher) {
  //    hasher.combine(id)
  //  }
}
