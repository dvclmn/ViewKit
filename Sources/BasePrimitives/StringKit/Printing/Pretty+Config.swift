//
//  PrettyPrint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

public struct PrettyPrintConfig: Sendable {
  public var maxDepth: Int = 10
  public var indentSize: Int = 2
  public var indentChar: Character = " "
  public var arrayPrefix: String = "["
  public var arraySuffix: String = "]"
  public var dictPrefix: String = "{"
  public var dictSuffix: String = "}"
  public var showTypeNames: Bool = true
  public var compactCollections: Bool = false  // Single line for small collections
  public var compactThreshold: Int = 3  // Max items before expanding
  public var keyValueSeparator: String = ": "
  public var itemSeparator: String = ","

  public static let `default` = PrettyPrintConfig()
  public static let compact = PrettyPrintConfig(
    compactCollections: true,
    compactThreshold: 5
  )
}

extension PrettyPrintConfig {

  public func overflowDescription<T>(for value: T) -> String {
    "\(typeName(value)){...}"
  }

  public func indent(_ depth: Int) -> String {
    String(repeating: indentChar, count: depth * indentSize)
  }

  public func typeName<T>(_ value: T) -> String {
    guard showTypeNames else { return "" }
    let type = String(describing: type(of: value))
    return "<\(type)> "
  }
}

// MARK: - Optional

extension Optional: PrettyPrintable where Wrapped: PrettyPrintable {
  public func pretty(_ config: PrettyPrintConfig, depth: Int) -> String {
    switch self {
      case .none:
        return "\(config.typeName(self))nil"
      case .some(let value):
        return value.pretty(config, depth: depth)
    }
  }
}
