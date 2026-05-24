//
//  Timing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/1/2026.
//

import AppKit
import CoreTools
import ViewTools

/// ```
/// var clock = FixedStepClock(step: 1.0 / 30.0)
///
/// for await frame in DisplayClock.frames() {
///   if clock.advance(delta: frame.delta) {
///     updateSimulation()
///     redrawCanvas()
///   }
/// }
/// ```
@MainActor
public struct FixedStepClock {
  let step: CFTimeInterval?
  private(set) var accumulator: CFTimeInterval = 0

  public init(framerate: FrameRate = .fps60) {
    self.step = framerate.rate
  }

  public mutating func advance(delta: CFTimeInterval) -> Bool {
    accumulator += delta
    if let step, accumulator >= step {
      accumulator -= step
      return true
    }
    return false
//    if accumulator >= step {
//      accumulator -= step
//      return true
//    }
//    return false
  }
}

enum CVTime {
  static func seconds(_ ts: CVTimeStamp) -> CFTimeInterval {
    if ts.videoTimeScale != 0 && ts.videoTime != 0 {
      return CFTimeInterval(ts.videoTime) / CFTimeInterval(ts.videoTimeScale)
    }

    if ts.hostTime != 0 {
      var info = mach_timebase_info_data_t()
      mach_timebase_info(&info)
      let nanos = CFTimeInterval(ts.hostTime) * CFTimeInterval(info.numer) / CFTimeInterval(info.denom)
      return nanos / 1_000_000_000
    }

    return 0
  }
}

//extension CVTimeStamp {
//  fileprivate var seconds: CFTimeInterval {
//    if videoTimeScale != 0 && videoTime != 0 {
//      return CFTimeInterval(Double(videoTime) / Double(videoTimeScale))
//    }
//
//    if hostTime != 0 {
//      var timebase = mach_timebase_info_data_t()
//      mach_timebase_info(&timebase)
//      let nanos = Double(hostTime) * Double(timebase.numer) / Double(timebase.denom)
//      return nanos / 1_000_000_000
//    }
//
//    return 0
//  }
//}
