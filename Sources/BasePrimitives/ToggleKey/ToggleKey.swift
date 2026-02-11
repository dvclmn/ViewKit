//
//  ToggleKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

/// In a View:
/// ```
/// struct InspectorView: View {
///   var body: some View {
///     Form {
///       // Type-safe, compile-time checked
///       ShaderControlsSection()
///         .togglable(ShaderEnabledKey.self)
///
///       AdvancedSection()
///         .togglable(AdvancedControlsKey.self)
///     }
///   }
/// }
/// ```
///
/// Reference the same persisted state elsewhere:
/// ```
/// struct CanvasView: View {
///   @OptionallyPersisted(ShaderEnabledKey.self) var shadersEnabled: Bool
///
///   var body: some View {
///     Canvas { context, size in
///       if shadersEnabled {
///         // Apply shaders
///       }
///     }
///   }
/// }
/// ```
///
/// Or use AppStorage directly:
/// ```
/// struct AnotherView: View {
///   @AppStorage(ShaderEnabledKey.storageKey)
///   var shadersEnabled = ShaderEnabledKey.defaultValue
///
///   var body: some View {
///     Text("Shaders: \(shadersEnabled ? "On" : "Off")")
///   }
/// }
/// ```
public protocol PersistenceKey: Sendable {
  associatedtype Value: Sendable

  /// Naming guide example: {domain} + {section} + {kind}
  /// `breathingWaves.shaders.enabled`
  static var storageKey: String { get }
  static var defaultValue: Value { get }
}

/// Convenience for Bool toggles
/// Note: Will probably need per-AppStorage-supported-types declarations?
public protocol ToggleKey: PersistenceKey where Value == Bool {

  static var displayName: String { get }
  static var kind: ToggleKind { get }
}

extension ToggleKey {

  public static var kind: ToggleKind { .enabled }
  public static var defaultValue: Bool { true }

  /// "{domain}.{section}{KindSuffix}"
  public static func key(from domain: String, _ section: String) -> String {
    "\(domain).\(section)\(kind.camelSuffix)"
  }

  /// Default displayName derived from storageKey:
  /// "breathingWaves.lineStyleExpanded" -> "Line Style"
  /// "actionLines.colourPickerEnabled" -> "Colour Picker"
  public static var displayName: String {
    let last = storageKey.split(separator: ".").last.map(String.init) ?? storageKey
    let section =
      last.hasSuffix(kind.camelSuffix)
      ? String(last.dropLast(kind.camelSuffix.count))
      : last

    return section.splitCamelCase().capitalisingFirstLetter()
  }
}

extension String {
  fileprivate func splitCamelCase() -> String {
    var out = ""
    out.reserveCapacity(count + 8)

    var prevWasLower = false
    for scalar in unicodeScalars {
      let isUpper = CharacterSet.uppercaseLetters.contains(scalar)
      if isUpper, prevWasLower { out.append(" ") }
      out.append(Character(scalar))
      prevWasLower = CharacterSet.lowercaseLetters.contains(scalar)
    }
    return out
  }

  fileprivate func capitalisingFirstLetter() -> String {
    guard let first else { return self }
    return String(first).uppercased() + dropFirst()
  }
}

//extension ToggleKey {
//
//  /// Default kind for toggles unless overridden by the conformer
//  public static var kind: ToggleKind { .enabled }
//
//  /// Builds a storage key using the pattern: "{domain}.{section}{KindSuffix}"
//  /// Example: domain = "breathingWaves", section = "shaders", kind = .enabled
//  /// Result: "breathingWaves.shadersEnabled"
//  public static func key(
//    from domain: String,
//    _ section: String
//  ) -> String {
//    "\(domain).\(section)\(kind.camelSuffix)"
//  }
//}

/// A simple registry. Only for catching duplicate keys at runtime (during development)
/// Call at app launch:
/// ```
///  public static func registerAll() {
///    register(ShaderEnabledKey.self)
///    register(AdvancedControlsKey.self)
///  }
///  ```
@MainActor
public enum PersistenceKeyRegistry: Sendable {
  private static var registeredKeys: Set<String> = []

  public static func register<K: PersistenceKey>(_ keyType: K.Type) {
    let key = K.storageKey
    assert(
      !registeredKeys.contains(key),
      "Duplicate persistence key: '\(key)' already registered"
    )
    registeredKeys.insert(key)
  }

}
