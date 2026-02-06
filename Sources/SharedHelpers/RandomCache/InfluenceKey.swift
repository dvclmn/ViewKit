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
public struct AnyInfluenceKey: Hashable, CustomStringConvertible {
  private let box: AnyHashable
  private let _description: () -> String
  public init<Value>(_ key: InfluenceKey<Value>) {
    self.box = AnyHashable(key.rawValue)
    self._description = { key.rawValue }
  }
  public var description: String { _description() }
  }
