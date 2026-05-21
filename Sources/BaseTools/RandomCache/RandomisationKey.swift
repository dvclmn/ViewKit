//
//  RandomisationKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

/// A small, reusable way to express "invalidate the cache if..."
/// By default we derive a stable String from the inputs that matter.
public protocol RandomisationKey {
  var cacheKey: String { get }
}

/// A default implementation that hashes any Hashable inputs together.
/// Use this when you want to compose a key from multiple pieces.
public struct DefaultRandomisationKey: RandomisationKey {
  private let components: [AnyHashable]
  public init(_ components: [AnyHashable]) {
    self.components = components
  }
  public var cacheKey: String {
    /// Stable string derived from the components' combined hash.
    /// If any component changes, the key changes and the cache invalidates.
    var hasher = Hasher()
    components.forEach { hasher.combine($0) }
    return String(hasher.finalize(), radix: 16)
  }
}
