//
//  AnimationTimeline.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import CoreTools
import SwiftUI

public typealias TimelineOutput = (_ now: TimeInterval) -> Void

public struct AnimationTimeline<Content: View>: View {
  @Environment(\.isPaused) private var isPaused
  @Environment(\.frameRate) private var frameRate
  //  @State private var store = TimelineHandler()

  //  let isPaused: Bool
  let content: (TimeInterval) -> Content
  //  let content: Content
  //  let didUpdateClock: TimelineOutput

  public init(
    //    isPaused: Bool = false,
  @ViewBuilder content: @escaping (TimeInterval) -> Content = { _ in EmptyView() }, 
    //    didUpdateClock: @escaping TimelineOutput = { _ in },
  ) {
    //    self.isPaused = isPaused
    self.content = content
    //    self.didUpdateClock = didUpdateClock
  }

  public var body: some View {

    TimelineView(
      .animation(
        minimumInterval: frameRate.rate,
        paused: isPaused
      )
    ) { context in
      content(context.date.timeIntervalSinceReferenceDate)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.animationClock, context.date.timeIntervalSinceReferenceDate)
      //        .task(id: context.date.timeIntervalSinceReferenceDate) {
      //          didUpdateClock(context.date.timeIntervalSinceReferenceDate)
      //        }
    }
  }
}
