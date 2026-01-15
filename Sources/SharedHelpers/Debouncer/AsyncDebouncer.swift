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
/// Also: Don't use the one debouncer instance for
/// two separate tasks, or one may cancel the other. Use seperate instances.

@Observable
public final class AsyncDebouncer {
  private var task: Task<Void, Never>?
  private let interval: Duration
  //  public init() {}
  public init(interval: CGFloat = 0.2) {
    self.interval = Duration.seconds(interval)
  }

  @MainActor
  public func execute(
    //    interval: CGFloat = 0.2,
    //  public func execute<T: Sendable>(
    action: @escaping @Sendable () async -> Void
      //    action: @escaping @Sendable () async -> T?
  ) {
    //  ) async -> T? {

    /// Cancel any previous task
    task?.cancel()

    task = Task {
      try? await Task.sleep(for: interval)
      //      try? await Task.sleep(for: Duration.seconds(interval))
      if !Task.isCancelled {
        await action()
      }
    }
    //    return await withCheckedContinuation { cont in
    //      task = Task { [interval, action] in
    //        try? await Task.sleep(for: interval)
    //        guard !Task.isCancelled else {
    //          cont.resume(returning: nil)
    //          return
    //        }
    //        cont.resume(returning: await action())
    //      }
    //    }
  }

  deinit {
    task?.cancel()
  }
}
