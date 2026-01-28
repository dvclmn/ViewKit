//
//  Engine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import AppKit

@MainActor
final class Engine: NSObject {
  private var displayLink: CVDisplayLink?
  private let handler: (Timestamps) -> Void

  init(handler: @escaping (Timestamps) -> Void) {
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

        let ts = CVTime.seconds(now.pointee)
        let target = CVTime.seconds(outputTime.pointee)

        let pair = Timestamps(
          timestamp: ts,
          targetTimestamp: target
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
