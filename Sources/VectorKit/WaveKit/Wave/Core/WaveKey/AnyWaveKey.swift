//
//  AnyWaveKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 26/1/2026.
//

import Foundation

public struct AnyWaveKey: Hashable, @unchecked Sendable {
  public let codingKey: String
  public let defaultValue: ConfiguredWave
  
  // We store the "erased" type here
  private let baseType: any WaveKey.Type
  
  public init<T: WaveKey>(_ type: T.Type) {
    self.codingKey = T.codingKey
    self.defaultValue = T.defaultValue
    self.baseType = type
  }
  
  /// Casting back to a specific type
  public func asType<T: WaveKey>(_ type: T.Type) -> T.Type? {
    return baseType as? T.Type
  }
  
  /// Checking if it IS a certain type
  public func isA<T: WaveKey>(_ type: T.Type) -> Bool {
    return baseType == type
  }
  
  public func hash(into hasher: inout Hasher) {
    /// Use the type's unique identity for hashing
    hasher.combine(ObjectIdentifier(baseType))
  }
  
  public static func == (lhs: AnyWaveKey, rhs: AnyWaveKey) -> Bool {
    lhs.baseType == rhs.baseType
  }
}

extension AnyWaveKey: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    /// Only save the string identifier
    try container.encode(codingKey)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let identifier = try container.decode(String.self)
    
    // Use the registry to find the original type
    guard let type = WaveKeyRegistry.lookup(identifier) else {
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Unknown WaveKey identifier: \(identifier). Did you register it?"
      )
    }
    
    // Re-initialize using the type we found
    self.init(type)
  }
}

//public struct AnyWaveKey: Hashable, Sendable {
//  public let codingKey: String
//  public let defaultValue: ConfiguredWave
//
//  /// Use the underlying type's `ObjectIdentifier` or the `codingKey`
//  /// to ensure uniqueness in a Dictionary.
//  private let identifier: String
//
//  public init<T: WaveKey>(_ type: T.Type) {
//    self.codingKey = T.codingKey
//    self.defaultValue = T.defaultValue
//    self.identifier = T.codingKey
//  }
//
//  public func hash(into hasher: inout Hasher) {
//    hasher.combine(identifier)
//  }
//
//  public static func == (lhs: AnyWaveKey, rhs: AnyWaveKey) -> Bool {
//    lhs.identifier == rhs.identifier
//  }
//}
