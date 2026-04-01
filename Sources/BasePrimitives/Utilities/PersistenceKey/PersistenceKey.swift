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
