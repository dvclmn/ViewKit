//
//  ZoomGesture.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/3/2026.
//

import SwiftUI

struct ZoomGesture: Gesture {
  @Environment(\.unsafeZoomRange) private var unsafeZoomRange

  /// Per-gesture accumulator
  @State private var lastMagnification: Double = 1

  @Binding var internalZoom: Double
  var externalZoom: Binding<Double>?
//  @Binding var externalZoom: Double?
  @Binding var isGesturing: Bool
  let didUpdateEvent: ZoomEventUpdate

  var body: some Gesture {
    //  private var zoomGesture: some Gesture {
    MagnifyGesture()
      .onChanged { value in
        let isGestureStart = !isGesturing
        isGesturing = true

        /// value.magnification is absolute since gesture start.
        /// Convert to incremental delta:
        let delta = value.magnification / lastMagnification
        lastMagnification = value.magnification

        let previousZoom = internalZoom
        let newZoom = (previousZoom * delta).clamped(to: unsafeZoomRange)

        let event = ZoomGestureEvent(
          phase: .changed,
          previousZoom: previousZoom,
          proposedZoom: newZoom,
          magnification: value.magnification,
          magnificationDelta: delta,
          isGestureStart: isGestureStart
        )
        let resolvedZoom = (didUpdateEvent(event) ?? newZoom)
          .clamped(to: unsafeZoomRange)

        internalZoom = resolvedZoom
        externalZoom?.wrappedValue = resolvedZoom
      }
      .onEnded { value in
        isGesturing = false
        lastMagnification = 1

        let previousZoom = internalZoom
        let final = previousZoom.clamped(to: unsafeZoomRange)
        let event = ZoomGestureEvent(
          phase: .ended,
          previousZoom: previousZoom,
          proposedZoom: final,
          magnification: value.magnification,
          magnificationDelta: 1,
          isGestureStart: false
        )
        let resolvedFinal = (didUpdateEvent(event) ?? final)
          .clamped(to: unsafeZoomRange)

        //        externalZoom?.wrappedValue = Double(resolvedFinal)
        internalZoom = resolvedFinal
        externalZoom?.wrappedValue = resolvedFinal
      }
  }
}
