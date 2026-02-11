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
public protocol PersistenceKey {
  associatedtype Value: Sendable
  static var storageKey: String { get }
  static var defaultValue: Value { get }
}

/// Convenience for Bool toggles
/// Note: Will probably need per-AppStorage-supported-types declarations?
public protocol ToggleKey: PersistenceKey where Value == Bool {
  static var displayName: String { get }
}

/// Provide default displayName from storageKey
extension ToggleKey {
  public static var displayName: String {
    /// Convert "shader.effects.enabled" -> "Shader Effects Enabled"
    storageKey
      .split(separator: ".")
      .map { $0.capitalized }
      .joined(separator: " ")
  }
}

/// A simple registry. Only for catching duplicate keys at runtime (during development)
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

  // Call at app launch:
  //  public static func registerAll() {
  //    register(ShaderEnabledKey.self)
  //    register(AdvancedControlsKey.self)
  //    register(AnimationEnabledKey.self)
  //  }
}
