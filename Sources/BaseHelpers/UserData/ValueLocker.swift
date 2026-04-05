//
//  ValueLocker.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import Foundation

/// ```
/// import Sharing
///
/// public struct SharedValueLocker<Value>: ValueLocker {
///   private let shared: Shared<Value>  // or SharedReader<Value> if you read via reader
///
///   public init(shared: Shared<Value>) {
///     self.shared = shared
///   }
///
///   public func withLock(_ update: (inout Value) -> Void) {
///     shared.withLock(update)
///   }
/// }
/// ```
///
/// Load it:
/// ```
/// let locker = SharedProjectionLocker<Value>(withLock: store.$storage.withLock)
/// ```
///
/// For non-Sharing
/// ```
/// public final class MainActorLocker<Value>: ValueLocker {
///   private var value: Value
///   public init(value: Value) { self.value = value }
///
///   public func withLock(_ update: (inout Value) -> Void) {
///     // Ensure main-actor if necessary
///     if Thread.isMainThread {
///       update(&value)
///     } else {
///       DispatchQueue.main.sync {
///         update(&value)
///       }
///     }
///   }
///
///   // Optionally expose a way to read the value
///   public var current: Value { value }
/// }
/// ```
//public protocol ValueLocker<Value> {
//  associatedtype Value
//  /// Mutate the underlying persisted value in a safe, serialized manner.
//  func withLock(_ update: @escaping (inout Value) -> Void)
//}
