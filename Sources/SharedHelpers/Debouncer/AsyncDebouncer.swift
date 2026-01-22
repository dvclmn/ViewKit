//
//  AsyncDebouncer.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2025.
//

import Foundation

/// Important: Use with `@State` like this:
/// `@State private var debouncer = AsyncDebouncer()`
///
/// Not like this ~~`let debouncer = AsyncDebouncer()`~~
///
/// Also: Don't use the one debouncer instance for
/// two separate tasks, or one may cancel the other. Use seperate instances.
@Observable
public final class AsyncDebouncer {
  private var task: Task<Void, Never>?
  private let interval: Duration

  public init(interval: CGFloat = 0.2) {
    self.interval = Duration.seconds(interval)
  }

  @MainActor
  public func executeAsync(action: @escaping @Sendable () async -> Void) {
    /// Cancel any previous task
    task?.cancel()

    task = Task {
      try? await Task.sleep(for: interval)
      if !Task.isCancelled {
        await action()
      }
    }
  }
  
  @MainActor
  public func execute(action: @escaping @Sendable () -> Void) {
    Task {
      self.executeAsync(action: action)
    }
    
  }
  deinit {
    task?.cancel()
  }
}

