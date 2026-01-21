//
//  AnimationTimeline.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import SwiftUI

public typealias TimelineOutput = (_ now: TimeInterval) -> Void

public struct AnimationTimeline<Content: View>: View {
  //  @State private var store = TimelineHandler()

  let isPaused: Bool
  let content: Content
  let didUpdateClock: TimelineOutput

  public init(
    isPaused: Bool = false,
    @ViewBuilder content: @escaping () -> Content,
    didUpdateClock: @escaping TimelineOutput = { _ in },
  ) {
    self.isPaused = isPaused
    self.content = content()
    self.didUpdateClock = didUpdateClock
  }

  public var body: some View {

    TimelineView(
      .animation(
        //        minimumInterval: store.frameRate.value?.toDouble,
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

public enum FrameRate {
  case fps60
  case fps120
  case unlocked

  public var value: CGFloat? {
    switch self {
      case .fps60: 1 / 60
      case .fps120: 1 / 120
      case .unlocked: nil
    }
  }
}
