//
//  Line+Shaders.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/2/2026.
//

import Foundation

public typealias ShaderKey = ShaderEffect.Meta
/// A strongly-typed key you can use to refer to specific shaders
/// instead of using integer indices directly.
///
/// Add cases that make sense for your project.
//public enum ShaderKey: Hashable, Sendable {
//    case outline
//    case glow
//    case dash
//    case noise
//    case custom(String)
//
//    /// Optional default index mapping for well-known keys.
//    /// You can tweak these to match how you populate your shaders array.
//    var defaultIndex: Int? {
//        switch self {
//        case .outline: return 0
//        case .glow:    return 1
//        case .dash:    return 2
//        case .noise:   return 3
//        case .custom:  return nil
//        }
//    }
//}

/// Utilities to access an array of `ShaderEffect` with `ShaderKey`.
///
/// This keeps your call sites readable, e.g.:
///   shaders[.glow] = myGlowShader
///   let outline = shaders[.outline]
extension Array where Element == ShaderEffect {
  /// Safe getter by key. Uses the key's `defaultIndex` mapping.
  /// Returns `nil` if the index is not mapped or out of bounds.
  public subscript(key: ShaderKey) -> ShaderEffect? {
    get {
      //      guard let idx = indices.contains(idx) else { return nil }
      //      guard let idx = key.defaultIndex, indices.contains(idx) else { return nil }
      //      return self[idx]
      self.first(where: { $0.meta == key })
    }
    set {
      //      guard let idx = key.defaultIndex else { return }
      // Grow the array with placeholders if needed
      guard let newValue, let idx = firstIndex(of: newValue) else { return }
      //      guard let newValue, let idx = firstIndex(where: { $0.meta == key }) else { return }
      if idx >= count {
        self.reserveCapacity(idx + 1)
        //        while count < idx {
        //          self.append(Self.placeholderShader)
        //        }

        self.append(newValue)
      } else {
        self[idx] = newValue
      }
    }
  }

  /// Ensure capacity up to a given key's index and set the value.
  /// Useful when you know you'll assign to a higher index.
  @discardableResult
  public mutating func set(_ shader: ShaderEffect, for key: ShaderKey) -> ShaderEffect {
    self[key] = shader
    return shader
  }

  /// Returns the shader for key or inserts the provided default using the key's index.
  @discardableResult
  public mutating func getOrInsertDefault(for key: ShaderKey, makeDefault: () -> ShaderEffect) -> ShaderEffect
  {
    if let existing = self[key] { return existing }
    let created = makeDefault()
    self[key] = created
    return created
  }

  /// A placeholder ShaderEffect used when expanding the array or writing `nil`.
  /// Replace this with something appropriate for your app (e.g., a no-op shader).
//  private static var placeholderShader: ShaderEffect {
//    // If you have a real no-op ShaderEffect, return it here.
//    // For now we assume `ShaderEffect()` is constructible; adjust if needed.
//    return ShaderEffect.noShader
//  }
}
/// If you have an `ActionLine.Configuration` type with `var shaders: [ShaderEffect]`,
/// you can add convenience forwarding here once that type is available in this module.
/// Example (uncomment and adjust access levels as needed):
///
/// extension ActionLine.Configuration {
///     subscript(key: ShaderKey) -> ShaderEffect? {
///         get { shaders[key] }
///         set { shaders[key] = newValue }
///     }
/// }
