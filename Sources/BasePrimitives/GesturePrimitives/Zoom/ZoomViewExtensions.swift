//
//  ZoomViewExtensions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import SwiftUI

extension View {
  /// Stateful + binding sync using full zoom event context.
  /// Return `nil` from `didUpdateEvent` to accept the proposed zoom.
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

  /// Stateful + binding sync.
  /// Return `nil` from `didUpdateZoom` to accept the proposed zoom.
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

  /// Stateful + binding sync using full zoom event context.
  /// Return `nil` from `didUpdateEvent` to accept the proposed zoom.
  public func zoomGesture(
    zoom: Binding<CGFloat>,
    isEnabled: Bool = true,
    didUpdateEvent: @escaping ZoomEventUpdate
  ) -> some View {
    self.zoomGesture(
      zoom: zoom.toBindingDouble,
      isEnabled: isEnabled,
      didUpdateEvent: didUpdateEvent
    )
  }

  /// Stateful + binding sync.
  /// Return `nil` from `didUpdateZoom` to accept the proposed zoom.
  public func zoomGesture(
    zoom: Binding<CGFloat>,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
  ) -> some View {
    self.zoomGesture(
      zoom: zoom.toBindingDouble,
      isEnabled: isEnabled,
      didUpdateZoom: didUpdateZoom
    )
  }

  /// Pure internal state + callback using full zoom event context.
  /// Return `nil` from `didUpdateEvent` to accept the proposed zoom.
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

  /// Pure internal state + callback.
  /// Return `nil` from `didUpdateZoom` to accept the proposed zoom.
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
