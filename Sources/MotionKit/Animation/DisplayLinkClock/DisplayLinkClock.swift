//
//  DisplayLinkClock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import AppKit

@MainActor
public enum DisplayClock {

  public static func frames() -> AsyncStream<Timestamps> {
    AsyncStream { continuation in
      let engine = Engine { stamps in
        continuation.yield(stamps)
      }

      continuation.onTermination = { _ in
        Task { await engine.stop() }
      }
    }
  }
}

@MainActor
public struct Timestamps: Sendable {
//  public let timestamp: CFTimeInterval
//  public let targetTimestamp: CFTimeInterval
  
  public let timestamp: CFTimeInterval
  public let targetTimestamp: CFTimeInterval
  public let delta: CFTimeInterval

  public init(
    timestamp: CFTimeInterval,
    targetTimestamp: CFTimeInterval,
    delta: CFTimeInterval
  ) {
    self.timestamp = timestamp
    self.targetTimestamp = targetTimestamp
    self.delta = delta
  }
}
