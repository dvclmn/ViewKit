//
//  Engine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import AppKit

@MainActor
final class Engine: NSObject {
  private var link: CVDisplayLink?
  private let handler: (Timestamps) -> Void
  private var lastTimestamp: CFTimeInterval?

  init(handler: @escaping (Timestamps) -> Void) {
    self.handler = handler
    super.init()

    var displayLink: CVDisplayLink?
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink)
    link = displayLink

    guard let link else { return }

    CVDisplayLinkSetOutputCallback(
      link,
      { _, now, outputTime, _, _, context in
        guard let context else { return kCVReturnSuccess }
        let engine = Unmanaged<Engine>.fromOpaque(context).takeUnretainedValue()

        let ts = CVTime.seconds(now.pointee)
        let target = CVTime.seconds(outputTime.pointee)

        //        let pair = Timestamps(
        //          timestamp: ts,
        //          targetTimestamp: target,
        //          delta: <#T##CFTimeInterval#>
        //        )

        Task { @MainActor in
          engine.emit(timestamp: ts, target: target)
        }

        //        Task { @MainActor in
        //          engine.handler(pair)
        //        }

        return kCVReturnSuccess
      },
      Unmanaged.passUnretained(self).toOpaque()
    )

    CVDisplayLinkStart(link)
  }

  func stop() {
    if let link {
      CVDisplayLinkStop(link)
    }
    link = nil
  }

  private func emit(timestamp: CFTimeInterval, target: CFTimeInterval) {
    let delta = lastTimestamp.map { timestamp - $0 } ?? 0
    lastTimestamp = timestamp

    handler(
      .init(
        timestamp: timestamp,
        targetTimestamp: target,
        delta: delta
      ))
  }
}
