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
  // Used for leading-edge (immediate) execution to enforce a cooldown window
  private var cooldownTask: Task<Void, Never>?

  public init(interval: CGFloat = 0.2) {
    self.interval = Duration.seconds(interval)
  }

  @MainActor
  public func execute(action: @escaping @Sendable () async -> Void) {
    /// Cancel any previous task
    task?.cancel()

    task = Task {
      try? await Task.sleep(for: interval)
      if Task.isCancelled { return }
      await action()

    }
  }

  /// Executes immediately (leading edge) if there isn't an active cooldown window.
  /// Subsequent calls within the cooldown window are ignored until the interval elapses.
  /// This behaves like a throttle with a leading edge.
  @MainActor
  public func executeLeading(action: @escaping @Sendable () async -> Void) {
    // If we're currently within the cooldown window, ignore this trigger.
    if cooldownTask != nil { return }

    // Cancel any pending trailing debounced task.
    task?.cancel()

    // Run immediately.
    Task {
      await action()
    }

    // Start a cooldown window so additional triggers are ignored until the interval passes.
    cooldownTask = Task {
      try? await Task.sleep(for: interval)
      // Clear cooldown on the main actor when the window elapses.
      await MainActor.run { [weak self] in
        self?.cooldownTask?.cancel()
        self?.cooldownTask = nil
      }
    }
  }

  /// Executes the action either immediately (skipping the debounce delay) or with the standard trailing-edge debounce.
  /// - Parameters:
  ///   - immediateIf: When true, the action runs immediately (leading-edge). When false, it uses the standard trailing-edge debounce.
  ///   - action: The asynchronous action to perform.
  @MainActor
  public func execute(immediateIf shouldSkipDelay: Bool, action: @escaping @Sendable () async -> Void) {
    if shouldSkipDelay {
      executeLeading(action: action)
    } else {
      execute(action: action)
    }
  }

  deinit {
    task?.cancel()
  }
}

