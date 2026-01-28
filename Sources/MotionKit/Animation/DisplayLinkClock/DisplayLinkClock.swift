//
//  DisplayLinkClock.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import AppKit

struct TimestampPair {
  let timestamp: CFTimeInterval
  let targetTimestamp: CFTimeInterval
}

struct FrameTiming: Sendable {
  let timestamp: CFTimeInterval
  let targetTimestamp: CFTimeInterval
  let delta: CFTimeInterval
}

@MainActor
public enum DisplayClock {
  public static func timestamps() -> AsyncStream<Timestamps> {
    AsyncStream { continuation in
      let engine = Engine { pair in
        continuation.yield(Timestamps(pair))
      }

      continuation.onTermination = { _ in
        Task { await engine.stop() }
      }
    }
  }
}

extension DisplayClock {

  struct Timestamps {
    let timestamp: CFTimeInterval
    let targetTimestamp: CFTimeInterval

    init(_ pair: TimestampPair) {
      timestamp = pair.timestamp
      targetTimestamp = pair.targetTimestamp
    }
  }

  fileprivate struct TimestampPair {
    let timestamp: CFTimeInterval
    let targetTimestamp: CFTimeInterval
  }

  @MainActor
  fileprivate final class Engine: NSObject {
    private var displayLink: CVDisplayLink?
    private let handler: (TimestampPair) -> Void

    init(handler: @escaping (TimestampPair) -> Void) {
      self.handler = handler
      super.init()

      var link: CVDisplayLink?
      CVDisplayLinkCreateWithActiveCGDisplays(&link)
      displayLink = link

      guard let displayLink else { return }

      CVDisplayLinkSetOutputCallback(
        displayLink,
        { _, now, outputTime, _, _, context in
          guard let context else { return kCVReturnSuccess }
          let engine = Unmanaged<Engine>.fromOpaque(context).takeUnretainedValue()

          let pair = TimestampPair(
            timestamp: now.pointee.seconds,
            targetTimestamp: outputTime.pointee.seconds
          )

          Task { @MainActor in
            engine.handler(pair)
          }

          return kCVReturnSuccess
        },
        Unmanaged.passUnretained(self).toOpaque()
      )

      CVDisplayLinkStart(displayLink)
    }

    func stop() {
      if let displayLink {
        CVDisplayLinkStop(displayLink)
      }
      displayLink = nil
    }
  }
}

