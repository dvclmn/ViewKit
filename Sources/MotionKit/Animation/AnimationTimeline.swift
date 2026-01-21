//
//  AnimationTimeline.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import SwiftUI
import CoreTools

public typealias TimelineOutput = (_ now: TimeInterval) -> Void

public struct AnimationTimeline<Content: View>: View {
  @Environment(\.isPaused) private var isPaused
  @Environment(\.frameRate) private var frameRate
  //  @State private var store = TimelineHandler()

//  let isPaused: Bool
  let content: Content
  let didUpdateClock: TimelineOutput

  public init(
//    isPaused: Bool = false,
    @ViewBuilder content: @escaping () -> Content,
    didUpdateClock: @escaping TimelineOutput = { _ in },
  ) {
//    self.isPaused = isPaused
    self.content = content()
    self.didUpdateClock = didUpdateClock
  }

  public var body: some View {

    TimelineView(
      .animation(
        minimumInterval: frameRate.rate,
        paused: isPaused
      )
    ) { context in
      content
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task(id: context.date.timeIntervalSinceReferenceDate) {
          didUpdateClock(context.date.timeIntervalSinceReferenceDate)
        }
    }
  }
}

//public struct TimelineHandler {

//  var isPaused: Bool = false

//  var frameRate: FrameRate = .fps60

/// Internal timekeeping
//  private var lastTime: CFTimeInterval?
//}

//extension TimelineHandler {
//  mutating func tick(
//    now: CFTimeInterval,
////    didUpdateClock: TimelineOutput
//  ) -> CGFloat {
//
//    print("Tick happened?")
//    /// Compute dt
//    let delta: CGFloat
//    guard let last = lastTime else {
//      return .zero
//    }
//    delta = max(0, CGFloat(now - last))
//    lastTime = now
//
//    return delta
////    didUpdateClock(delta)
//  }
//}

