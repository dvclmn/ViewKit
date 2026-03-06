//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import BasePrimitives
//import CoreTools
import SwiftUI

public typealias ZoomEventUpdate = (ZoomGestureEvent) -> Double?
public typealias ZoomUpdate = (Double, InteractionPhase) -> Double?

public struct ZoomModifier: ViewModifier {
  @Environment(\.zoomRange) private var zoomRange
  @Environment(\.modifierKeys) private var modifierKeys

  /// source of truth during gesture
  @State private var internalZoom: Double

  /// per-gesture accumulator
  @State private var lastMagnification: Double = 1

  /// helps with external sync
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
      .simultaneousGesture(zoomGesture, isEnabled: isEnabled)
      .onChange(of: modifierKeys) {
        // If modifier keys change mid-pinch, don't let the next delta go bonkers.
        lastMagnification = 1
      }
      .onChange(of: externalZoom?.wrappedValue) { _, newValue in
        // External source changed (e.g. reset button / slider / programmatic change).
        // Only adopt it when we are NOT currently gesturing.
        guard !isGesturing, let newValue else { return }
        internalZoom = Double(newValue).clamped(to: rangeForZoom)
      }
  }
}

extension ZoomModifier {
  private var rangeForZoom: ClosedRange<Double> {
    guard let zoomRange else {
      assertionFailure("Zoom range is missing from environment for ZoomModifier")
      return 0.2...10
    }
    return zoomRange
  }
  private var zoomGesture: some Gesture {
    MagnifyGesture()
      .onChanged { value in
        let isGestureStart = !isGesturing
        isGesturing = true

        /// value.magnification is absolute since gesture start.
        /// Convert to incremental delta:
        let delta = value.magnification / lastMagnification
        lastMagnification = value.magnification

        let previousZoom = internalZoom
        let newZoom = (previousZoom * delta).clamped(to: rangeForZoom)
        let event = ZoomGestureEvent(
          phase: .changed,
          previousZoom: previousZoom,
          proposedZoom: newZoom,
          magnification: value.magnification,
          magnificationDelta: delta,
          isGestureStart: isGestureStart
        )
        let resolvedZoom = (didUpdateEvent(event) ?? newZoom)
          .clamped(to: rangeForZoom)

        internalZoom = resolvedZoom
        externalZoom?.wrappedValue = Double(resolvedZoom)
      }
      .onEnded { value in
        isGesturing = false
        lastMagnification = 1

        let previousZoom = internalZoom
        let final = previousZoom.clamped(to: rangeForZoom)
        let event = ZoomGestureEvent(
          phase: .ended,
          previousZoom: previousZoom,
          proposedZoom: final,
          magnification: value.magnification,
          magnificationDelta: 1,
          isGestureStart: false
        )
        let resolvedFinal = (didUpdateEvent(event) ?? final)
          .clamped(to: rangeForZoom)

        externalZoom?.wrappedValue = Double(resolvedFinal)
        internalZoom = resolvedFinal
      }
  }
}

extension View {
  /// Stateful + binding sync using full zoom event context
  public func zoomGesture(
    zoom: Binding<Double>,
    isEnabled: Bool = true,
    didUpdateEvent: @escaping ZoomEventUpdate
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: Double(zoom.wrappedValue),
        zoom: zoom,
        isEnabled: isEnabled,
        didUpdateEvent: didUpdateEvent
      )
    )
  }

  /// Stateful + binding sync
  public func zoomGesture(
    zoom: Binding<Double>,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: Double(zoom.wrappedValue),
        zoom: zoom,
        isEnabled: isEnabled,
        didUpdateEvent: { event in
          didUpdateZoom(event.proposedZoom, event.phase)
        }
      )
    )
  }

  /// Pure internal state + callback using full zoom event context
  public func zoomGesture(
    initial: Double,
    isEnabled: Bool = true,
    didUpdateEvent: @escaping ZoomEventUpdate
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: initial,
        zoom: nil,
        isEnabled: isEnabled,
        didUpdateEvent: didUpdateEvent
      )
    )
  }

  /// Pure internal state + callback
  public func zoomGesture(
    initial: Double,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: initial,
        zoom: nil,
        isEnabled: isEnabled,
        didUpdateEvent: { event in
          didUpdateZoom(event.proposedZoom, event.phase)
        }
      )
    )
  }
}
