//
//  ZoomViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import SwiftUI

// MARK: - Mode A: Binding (simple)
//
// The modifier owns zoom state and writes clamped values to the binding.
// Use when you just need a zoomable view without custom zoom logic.

extension View {

  /// Simple binding-driven zoom. The modifier handles gesture math and clamping.
  public func zoomGesture(
    zoom: Binding<Double>,
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: zoom.wrappedValue,
        zoom: zoom,
        isEnabled: isEnabled,
        didUpdateEvent: { _ in nil }
      )
    )
  }

  /// Simple binding-driven zoom (CGFloat convenience).
  public func zoomGesture(
    zoom: Binding<CGFloat>,
    isEnabled: Bool = true
  ) -> some View {
    self.zoomGesture(
      zoom: zoom.toBindingDouble,
      isEnabled: isEnabled
    )
  }
}

// MARK: - Mode B: Event callback (advanced)
//
// The caller owns zoom state. The modifier tracks gesture deltas and
// sends events; the callback returns the resolved zoom value.
// Use when you need focus-preserving zoom, pan adjustment, or custom logic.

extension View {

  /// Event-driven zoom with full ``ZoomGestureEvent`` context.
  /// Return `nil` from `didUpdateEvent` to accept the proposed zoom.
  public func zoomGesture(
    initial: Double = 1,
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

  /// Simplified event-driven zoom receiving just `(proposedZoom, phase)`.
  /// Return `nil` from `didUpdateZoom` to accept the proposed zoom.
  public func zoomGesture(
    initial: Double = 1,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate
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
