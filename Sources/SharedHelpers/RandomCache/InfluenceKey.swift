//
//  InfluenceKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

public struct InfluenceKey<Value: Hashable>: Hashable, ExpressibleByStringLiteral, CustomStringConvertible {
  public let rawValue: String
  public init(_ rawValue: String) { self.rawValue = rawValue }
  public init(stringLiteral value: String) { self.rawValue = value }
  public var description: String { rawValue }
}

/// Type-erased key wrapper to keep `influences` dictionary heterogeneous while
/// preserving key identity and hashing.
public struct AnyInfluenceKey: Hashable, Equatable, CustomStringConvertible {
  public let rawValue: String
  public init<Value>(_ key: InfluenceKey<Value>) {
    self.rawValue = key.rawValue
  }
  public var description: String { rawValue }

  /// Equatable is synthesized via rawValue; explicit for clarity.
  public static func == (lhs: AnyInfluenceKey, rhs: AnyInfluenceKey) -> Bool {
    lhs.rawValue == rhs.rawValue
  }

  /// Hashable based solely on rawValue to ensure stable identity across generic Value types.
  public func hash(into hasher: inout Hasher) {
    hasher.combine(rawValue)
  }
}
