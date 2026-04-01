//
//  PersistenceKeyRegistry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/4/2026.
//

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
      "Duplicate persistence key: '\(key)' already registered",
    )
    registeredKeys.insert(key)
  }
  
}
