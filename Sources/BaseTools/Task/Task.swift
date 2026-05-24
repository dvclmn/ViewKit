//
//  Task.swift
//  Collection
//
//  Created by Dave Coleman on 26/9/2024.
import CoreTools
import Foundation

/// Usage
///
/// ```swift
/// await Task.delay(seconds: 0.4)
/// // Your task here
/// ```
///
/// If you want to run it on a background queue, you can specify:
///
/// ```swift
/// await Task.delay(seconds: 0.4, on: .global())
/// // Your task here
/// ```
///

extension Task where Success == Never, Failure == Never {
  public static func delay(seconds: Double, on queue: DispatchQueue = .main) async {
    await withCheckedContinuation { continuation in
      queue.asyncAfter(deadline: .now() + seconds) {
        continuation.resume()
      }
    }
  }

  @MainActor public static func debounceIfNeeded(
    _ debouncer: AsyncDebouncer?,
    action: @escaping () -> Void,
  ) {

    if let debouncer {
      debouncer.execute { @MainActor in
        action()
      }
    } else {
      action()
    }
  }
}
