//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import ColourKit
import Foundation

/// Rough equivalent to `EnvironmentValues`
///
/// `stack[Fundamental.self].wave.phase += delta`
/// `stack[Fundamental.self].settings.isEnabled.toggle()`
//@dynamicMemberLookup
public struct WaveStack: @unchecked Sendable {
  private var storage: [ObjectIdentifier: Any] = [:]

  public init() {}
}

extension WaveStack {
  //  public subscript<T>(dynamicMember keyPath: KeyPath<Self, T>) {
  //
  //  }
  public subscript<K: WaveKey>(_ key: K.Type) -> K.Value {
    get { storage[ObjectIdentifier(key)] as? K.Value ?? K.defaultValue }
    set { storage[ObjectIdentifier(key)] = newValue }
  }
}

// MARK: - Codable handling
extension WaveStack {

  /// Converts current state to a Codable projection
  @MainActor
  public func codable() -> CodableWaveStack {
    var result: [String: WaveDescriptor] = [:]

    // We iterate the registry to see what keys we care about encoding
    for (codingKey, keyType) in WaveKeyRegistry.all {
      // We use the subscript to get the current value (or default)
      let value = storage[ObjectIdentifier(keyType)] as? WaveDescriptor ?? keyType.defaultValue
      result[codingKey] = value
    }

    return CodableWaveStack(result)
  }

  @MainActor
  public mutating func apply(_ projection: CodableWaveStack) {
    for (key, descriptor) in projection.waves {
      WaveKeyRegistry.apply(descriptor: descriptor, key: key, to: &self)
    }
  }

  // Internal helper for the registry to inject values
  fileprivate mutating func setValue(_ value: WaveDescriptor, for keyType: any CodableWaveKey.Type) {
    storage[ObjectIdentifier(keyType)] = value
  }

  public func snapshot<K: CodableWaveKey>(_ key: K.Type) -> (String, WaveDescriptor) {
    (K.codingKey, self[K.self])
  }

  public mutating func restore<K: CodableWaveKey>(
    _ key: K.Type,
    from dict: [String: WaveDescriptor]
  ) {
    if let value = dict[K.codingKey] {
      self[K.self] = value
    }
  }
}

/// ```
/// stack.update(Fundamental.self) {
///   $0.wave.amplitude += 0.05
///   $0.wave.phase += delta
/// }
/// ```
extension WaveStack {
  mutating func update<K: WaveKey>(
    _ key: K.Type,
    _ body: (inout K.Value) -> Void
  ) {
    var value = self[key]
    body(&value)
    self[key] = value
  }
}

@MainActor
public enum WaveKeyRegistry {
  private(set) static var all: [String: any CodableWaveKey.Type] = [:]

  public static func register<K: CodableWaveKey>(_ key: K.Type) {
    all[K.codingKey] = key
  }

  /// Helper to apply a descriptor to a stack using the type-erased key
  static func apply(descriptor: WaveDescriptor, key: String, to stack: inout WaveStack) {
    guard let keyType = all[key] else { return }
    stack.setValue(descriptor, for: keyType)
  }
}

//  public func codable() -> CodableWaveStack {
//    var result: [String: WaveDescriptor] = [:]
//
//    for (id, value) in storage {
//      if let entry = value as? any CodableWaveKey {
//        result[entry.codingKey] = entry.waveLayer
//      }
//    }
//
//    return CodableWaveStack(waves: result)
//  }
//
//  mutating func apply(_ codable: CodableWaveStack) {
//    for (key, layer) in codable.waves {
//      applyDecodedWave(key: key, layer: layer)
//    }
//  }
//}

/// Important:
/// How is `BreathingWave` different to a wave, if at all?
/// Maybe it more just contains waves?
//public struct WaveStack: Codable, Sendable, Equatable {
//  //public struct BreathingWave: Codable, Sendable, Equatable {
//
//  //  public var colour: RGBColour
//  //  public var colourSecondary: RGBColour
//
//  let lineStyle: LineStyle
//  let pointStyle: PointStyle
//
//  /// I don't think a stack has a 'main' wave? I dunno?
//  //  let stackConfig: WaveConfig
//
//  let waves: [Wave.ID: WaveDescriptor]
//
//  public init(
//    lineStyle: LineStyle = .init(),
//    pointStyle: PointStyle = .init(),
//    waves: [Wave.ID : WaveDescriptor] = [:]
//  ) {
//    self.lineStyle = lineStyle
//    self.pointStyle = pointStyle
//    self.waves = waves
//  }
//}

/// The base circle radius.
//  public var circleRadius: CGFloat

/// The total number of circles (affects normalisation but not the wave shapes).
/// Could also be thought of as sample count
/// This is now ``WaveConfig/sampleCount``
//  public var count: Int

/// ~~When shouldMaintainHeight is true, no matter what count is,
/// these circles are “packed” into this height.~~
///
/// How much of the vertical space the total wave takes up
/// Aka vertical frequency
//  public var compressionFactor: CGFloat

/// Horizontal left/right motion parameters.
//  public var horizontalWave: WaveModulator

/// Vertical spacing between circles (used when shouldMaintainHeight == false).
//  public var spacing: CGFloat

/// Breathing (spacing) wave: modulates the vertical position.
/// (When shouldMaintainHeight is true, the circles are laid out
///  over a fixed height, and then the breathing effect is added.)
//  public var verticalWave: WaveModulator
//  public var spacingWave: WaveModulator

//  public var shouldMaintainHeight: Bool

/// New: a modulation for the circle radius (so the circles can “pulse”).
//  public var radiusWave: WaveModulator

//  public init(
//    colour: RGBColour,
//    colourSecondary: RGBColour,
//    circleRadius: CGFloat,
//    count: Int,
//    compressionFactor: CGFloat,
//    horizontalWave: WaveModulator,
//    verticalWave: WaveModulator,
//    radiusWave: WaveModulator
////    colour: RGBColour = .purple,
////    colourSecondary: RGBColour = .orange,
////    circleRadius: CGFloat = 25,
////    count: Int = 60,
////    compressionFactor: CGFloat = 300,
////    horizontalWave: WaveModulator = .init(
////      isEnabled: true,
////      amp: 70,
////      freq: 2,
////      phase: 0.4,
////      cycles: 3
////    ),
////    spacingWave: WaveModulator =
////      .init(
////        isEnabled: true,
////        amp: 10,
////        freq: 1,
////        phase: 0,
////        cycles: 3
////      ),
////    radiusWave: WaveModulator =
////      .init(
////        isEnabled: true,
////        amp: 5,
////        freq: 1,
////        phase: 0,
////        cycles: 3
////      )
//  ) {
//    self.colour = colour
//    self.colourSecondary = colourSecondary
//    self.circleRadius = circleRadius
//    self.horizontalWave = horizontalWave
//    self.verticalWave = verticalWave
//    self.compressionFactor = compressionFactor
//    self.count = count
//    self.radiusWave = radiusWave
//  }
//}
