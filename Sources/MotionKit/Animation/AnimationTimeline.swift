//
//  AnimationTimeline.swift
//  BaseComponents
//
//  Created by Dave Coleman on 15/8/2025.
//

import CoreTools
import SwiftUI

//public typealias TimelineOutput = (_ now: TimeInterval) -> Void

public struct AnimationTimeline<Content: View>: View {
  @Environment(\.isPaused) private var isPaused
  @Environment(\.frameRate) private var frameRate

  let content: (TimeInterval) -> Content

  public init(
    @ViewBuilder content: @escaping (TimeInterval) -> Content,
  ) {
    self.content = content
  }

  public var body: some View {

    TimelineView(
      .animation(
        minimumInterval: frameRate.rate,
        paused: isPaused
          //        paused: isPaused.wrappedValue
      )
    ) { context in
      content(context.date.timeIntervalSinceReferenceDate)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.animationClock, context.date.timeIntervalSinceReferenceDate)
    }
  }
}
