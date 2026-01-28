//
//  AsyncStream.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import Foundation

/// ```
/// for await tick in DisplayClock.timestamps().throttled(to: 30) {
///   // 30 FPS animation clock
/// }
/// ```

extension AsyncSequence where Element == Timestamps {
  @MainActor
  public func throttled(to fps: Double) -> AsyncStream<Element> {
    AsyncStream { continuation in
      Task { @MainActor in
        let minInterval = 1.0 / fps
        var lastEmission: CFTimeInterval?

        for try await value in self {
          if let last = lastEmission,
            value.timestamp - last < minInterval
          {
            continue
          }

          lastEmission = value.timestamp
          continuation.yield(value)
        }
      }
    }
  }
}
