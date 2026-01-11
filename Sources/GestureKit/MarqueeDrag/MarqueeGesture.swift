//
//  MarqueeGesture.swift
//  BaseComponents
//
//  Created by Dave Coleman on 3/8/2025.
//


import SwiftUI

struct MarqueeDragGesture: Gesture {
  @Binding var rect: CGRect?
  let dragThreshold: CGFloat
  let didUpdateRect: (PointerPhase) -> Void

  var body: some Gesture {
    /// IMPORTANT: `minimumDistance` must be set to zero,
    /// to allow both Drag *and* Tap detection. These are
    /// disambiguated via `dragThreshold`
    DragGesture(minimumDistance: 0)

      .onChanged { gestureValue in

        let newRect = gestureValue.toRect
        rect = newRect

        let isDrag: Bool = gestureValue.translation.eitherDimensionIsGreaterThan(dragThreshold)

        if isDrag {
          didUpdateRect(.drag(rect: newRect))
          
        } else {
          didUpdateRect(.tap(location: newRect.point(at: .bottomTrailing)))
        }

      }
      .onEnded { gestureValue in

        didUpdateRect(.ended)

        /// Resetting this value ensures we can start from a *new*
        /// last-recorded corner, for the next gesture.
        ///
        /// Failing to set this to `nil` would result in a stale value
        rect = nil
      }
  }
}
