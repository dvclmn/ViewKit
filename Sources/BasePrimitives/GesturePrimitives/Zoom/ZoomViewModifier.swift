//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import SwiftUI

/// Return a replacement zoom value, or `nil` to accept the gesture's proposal.
public typealias ZoomEventUpdate = (ZoomGestureEvent) -> Double?

/// Return a replacement zoom value for `(proposedZoom, phase)`, or `nil` to accept.
public typealias ZoomUpdate = (Double, InteractionPhase) -> Double?

public struct ZoomModifier: ViewModifier {
  @Environment(\.unsafeZoomRange) private var unsafeZoomRange

  /// Source of truth during the gesture.
  @State private var internalZoom: Double

  /// Tracks incremental deltas within the current magnify gesture.
  @State private var lastMagnification: Double = 1

  /// Helps with external sync.
  @State private var isGesturing: Bool = false

  private let externalZoom: Binding<Double>?
  let isEnabled: Bool
  let didUpdateEvent: ZoomEventUpdate

  init(
    initial: Double,
    zoom: Binding<Double>? = nil,
    isEnabled: Bool,
    didUpdateEvent: @escaping ZoomEventUpdate
  ) {
    self._internalZoom = State(initialValue: initial)
    self.externalZoom = zoom
    self.isEnabled = isEnabled
    self.didUpdateEvent = didUpdateEvent
  }

  public func body(content: Content) -> some View {
    content
      .gesture(magnifyGesture, isEnabled: isEnabled)
    
      .onChange(of: externalZoom?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button / slider / programmatic change).
        /// Only adopt it when we are NOT currently gesturing.
        guard !isGesturing, let newValue else { return }
        internalZoom = clampZoom(newValue)
      }
  }
}

extension ZoomModifier {
  private var magnifyGesture: some Gesture {
    MagnifyGesture()
      .onChanged { value in
        let isGestureStart = !isGesturing
        if isGestureStart {
          lastMagnification = 1
        }
        isGesturing = true

        /// MagnifyGesture reports absolute scale since start; convert to delta.
        let safeLast =
          lastMagnification.isFinite && lastMagnification > 0
          ? lastMagnification
          : 1
        let delta = value.magnification / safeLast
        lastMagnification = value.magnification

        let previousZoom = internalZoom
        let proposedZoom = previousZoom * delta

        let event = ZoomGestureEvent(
          phase: .changed,
          previousZoom: previousZoom,
          proposedZoom: proposedZoom,
          magnification: value.magnification,
          magnificationDelta: delta,
          isGestureStart: isGestureStart
        )

        let resolvedZoom = resolvedZoom(for: event, proposed: proposedZoom)
        commitZoom(resolvedZoom)
      }
      .onEnded { value in
        let previousZoom = internalZoom
        let finalZoom = clampZoom(previousZoom)

        let event = ZoomGestureEvent(
          phase: .ended,
          previousZoom: previousZoom,
          proposedZoom: finalZoom,
          magnification: value.magnification,
          magnificationDelta: 1,
          isGestureStart: false
        )

        let resolvedZoom = resolvedZoom(for: event, proposed: finalZoom)
        commitZoom(resolvedZoom)

        isGesturing = false
        lastMagnification = 1
      }
  }

  private func resolvedZoom(for event: ZoomGestureEvent, proposed: Double) -> Double {
    clampZoom(didUpdateEvent(event) ?? proposed)
  }

  private func clampZoom(_ value: Double) -> Double {
    value.clamped(to: unsafeZoomRange)
  }

  private func commitZoom(_ value: Double) {
    internalZoom = value
    externalZoom?.wrappedValue = value
  }
}
