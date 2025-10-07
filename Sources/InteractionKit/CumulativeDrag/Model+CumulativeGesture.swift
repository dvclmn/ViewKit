//
//  Model+DragState.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/7/2025.
//

import BaseHelpers
import SwiftUI

struct CumulativeDragGesture: Gesture {
  @Binding var tracker: CumulativeDragTracker
  @Binding var offset: CGSize
  let minDragDistance: CGFloat
  let isDragging: (Bool) -> Void

  var body: some Gesture {
    DragGesture(minimumDistance: minDragDistance)
      .onChanged { gestureValue in
        tracker.beginIfNeeded(latestValue: offset)
        guard let newOffset = tracker.computeOffset(translation: gestureValue.translation) else { return }
        offset = newOffset
        isDragging(true)
      }
      .onEnded { gestureValue in
        tracker.end()
        isDragging(false)
      }
  }
}
