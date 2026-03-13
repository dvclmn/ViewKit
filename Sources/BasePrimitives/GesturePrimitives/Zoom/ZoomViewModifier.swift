//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import SwiftUI

public typealias ZoomEventUpdate = (ZoomGestureEvent) -> Double?
public typealias ZoomUpdate = (Double, InteractionPhase) -> Double?

public struct ZoomModifier: ViewModifier {
  @Environment(\.unsafeZoomRange) private var unsafeZoomRange
  //  @Environment(\.zoomRange) private var zoomRange
  @Environment(\.modifierKeys) private var modifierKeys

  /// Source of truth during gesture
  @State private var internalZoom: Double

  /// Helps with external sync
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
      /// Was previously simultaneous gesture
      .gesture(
        ZoomGesture(
          internalZoom: $internalZoom,
          externalZoom: externalZoom,
          isGesturing: $isGesturing,
          didUpdateEvent: didUpdateEvent
        ),
        isEnabled: isEnabled
      )
//      .gesture(zoomGesture, isEnabled: isEnabled)
      //      .onChange(of: modifierKeys) {
      //        /// If modifier keys change mid-pinch, don't let the next delta go bonkers.
      //        lastMagnification = 1
      //      }
      .onChange(of: externalZoom?.wrappedValue) { _, newValue in
        /// External source changed (e.g. reset button / slider / programmatic change).
        /// Only adopt it when we are NOT currently gesturing.
        guard !isGesturing, let newValue else { return }
        internalZoom = Double(newValue).clamped(to: unsafeZoomRange)
      }
  }
}

extension ZoomModifier {

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
