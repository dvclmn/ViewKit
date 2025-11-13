//
//  PrettyPrint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import Foundation

// MARK: - Configuration

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
  public func indent(
    _ depth: Int,
    //    _ config: PrettyPrintConfig
  ) -> String {
    String(repeating: indentChar, count: depth * indentSize)
  }

  public func typeName<T>(
    _ value: T,
    //    _ config: PrettyPrintConfig
  ) -> String {
    guard showTypeNames else { return "" }
    let type = String(describing: type(of: value))
    return "<\(type)> "
  }
}

// MARK: - Protocol

public protocol PrettyPrintable {
  func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String
}

// MARK: - Default Implementation

extension PrettyPrintable {
  public func prettyPrint(_ config: PrettyPrintConfig = .default) {
    print(prettyDescription(config, depth: 0))
  }

  public var prettyDescription: String {
    prettyDescription(.default, depth: 0)
  }
}

// MARK: - Helper Functions

extension String {

}

// MARK: - Optional

extension Optional: PrettyPrintable where Wrapped: PrettyPrintable {
  public func prettyDescription(_ config: PrettyPrintConfig, depth: Int) -> String {
    switch self {
      case .none:
        return "\(config.typeName(self))nil"
      case .some(let value):
        return value.prettyDescription(config, depth: depth)
    }
  }
}

// MARK: - Custom Types Example

// For custom types, implement PrettyPrintable manually:

/// ```
/// struct Person: PrettyPrintable {
///   let name: String
///   let age: Int
///   let address: Address?
///   let hobbies: [String]
///
///   func prettyDescription(config: PrettyPrintConfig, depth: Int) -> String {
///     guard depth < config.maxDepth else { return "Person {...}" }
///
///     let ind = indent(depth, config)
///     let nextInd = indent(depth + 1, config)
///
///     return """
///         \(typeName(self, config))Person {
///         \(nextInd)name: \(name.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)age: \(age.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)address: \(address.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)hobbies: \(hobbies.prettyDescription(config: config, depth: depth + 1))
///         \(ind)}
///         """
///   }
/// }
///
/// struct Address: PrettyPrintable {
///   let street: String
///   let city: String
///   let zip: String
///
///   func prettyDescription(config: PrettyPrintConfig, depth: Int) -> String {
///     guard depth < config.maxDepth else { return "Address {...}" }
///
///     let ind = indent(depth, config)
///     let nextInd = indent(depth + 1, config)
///
///     return """
///         \(typeName(self, config))Address {
///         \(nextInd)street: \(street.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)city: \(city.prettyDescription(config: config, depth: depth + 1))
///         \(nextInd)zip: \(zip.prettyDescription(config: config, depth: depth + 1))
///         \(ind)}
///         """
///   }
/// }
/// ```
// MARK: - Usage Example

/// ```
/// let person = Person(
///   name: "Alice",
///   age: 30,
///   address: Address(street: "123 Main St", city: "Springfield", zip: "12345"),
///   hobbies: ["reading", "cycling", "photography"]
/// )
///
/// let people = [person, person]
/// let nestedData: [String: Any] = [
///   "count": 2,
///   "users": people
/// ]
///
/// // Print with default config
/// print("=== Default Config ===")
/// person.prettyPrint()
///
/// print("\n=== Compact Config ===")
/// person.prettyPrint(config: .compact)
///
/// print("\n=== Custom Config ===")
/// var customConfig = PrettyPrintConfig()
/// customConfig.showTypeNames = false
/// customConfig.indentSize = 4
/// customConfig.arrayPrefix = "🔵 ["
/// customConfig.arraySuffix = "]"
/// person.prettyPrint(config: customConfig)
///
/// print("\n=== Nested Arrays ===")
/// let matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
/// matrix.prettyPrint()
/// ```
