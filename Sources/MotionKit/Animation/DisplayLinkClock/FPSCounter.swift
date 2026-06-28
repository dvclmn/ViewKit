//
//  FPSCounter.swift
//  ViewKit
//
//  Created by Dave Coleman on 28/1/2026.
//

import SwiftUI

/// ```
/// let fpsCounter = FPSCounter()
///
/// for await tick in DisplayClock.timestamps() {
///   fpsCounter.tick(at: tick.timestamp)
/// }
/// ```
@MainActor
@Observable
public final class FPSCounter {
  private(set) var fps: Double = 0

  @ObservationIgnored private var frameCount = 0
  @ObservationIgnored private var lastSampleTime: CFTimeInterval = 0

  public func tick(at time: CFTimeInterval) {
    if lastSampleTime == 0 {
      lastSampleTime = time
      return
    }

    frameCount += 1
    let elapsed = time - lastSampleTime

    if elapsed >= 0.5 {
      fps = Double(frameCount) / elapsed
      frameCount = 0
      lastSampleTime = time
    }
  }
}
