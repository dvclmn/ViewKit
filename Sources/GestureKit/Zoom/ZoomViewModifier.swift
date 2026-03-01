//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
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
      print("⚠️ Need a zoom range to be supplied through the environment for ZoomModifier")
      //      assertionFailure("Need a zoom range to be supplied through the environment")
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

//public typealias ZoomUpdate = (CGFloat, InteractionPhase) -> CGFloat?
//
//public struct ZoomModifier: ViewModifier {
//  @Environment(\.canvasZoomRange) private var zoomRange
//  @Environment(\.modifierKeys) private var modifierKeys
//
////  @GestureState private var magnification: CGFloat = 1
//  @State private var initialZoom: CGFloat?
//  @State private var internalZoom: CGFloat  // <- source of truth
//
//  private let externalZoom: Binding<Double>?  // <- optional
//  let isEnabled: Bool
//  let didUpdateZoom: ZoomUpdate
//
//  init(
//    initial: CGFloat,
//    zoom: Binding<Double>? = nil,
//    isEnabled: Bool,
//    didUpdateZoom: @escaping ZoomUpdate
//  ) {
//    self._internalZoom = State(initialValue: initial)
//    self.externalZoom = zoom
//    self.isEnabled = isEnabled
//    self.didUpdateZoom = didUpdateZoom
//  }
//
//  public func body(content: Content) -> some View {
//    content
//      .simultaneousGesture(zoomGesture, isEnabled: isEnabled)
//      .onChange(of: modifierKeys) {
//        initialZoom = nil
//      }
//  }
//}
//extension ZoomModifier {
//
//  private var zoomGesture: some Gesture {
//    MagnifyGesture()
//      .onChanged { value in
//        // value.magnification is absolute since gesture start.
//        // Convert to incremental delta:
//        let delta = value.magnification / lastMagnification
//        lastMagnification = value.magnification
//
//        let newZoom = (internalZoom * delta).clamped(to: zoomRange)
//
//        internalZoom = newZoom
//        externalZoom?.wrappedValue = Double(newZoom)
//        _ = didUpdateZoom(newZoom, .changed)
//      }
//      .onEnded { value in
//        lastMagnification = 1
//
//        let final = internalZoom.clamped(to: zoomRange)
//        externalZoom?.wrappedValue = Double(final)
//        internalZoom = didUpdateZoom(final, .ended) ?? final
//      }
////      .updating($magnification) { value, state, _ in
////        state = value.magnification
////      }
////      .onChanged { value in
////
////        if initialZoom == nil {
////          initialZoom = internalZoom  // <- always valid
////        }
////
////        let newZoom = effectiveZoom(value)
////
////        internalZoom = newZoom
////        externalZoom?.wrappedValue = Double(newZoom)  // optional sync
////        _ = didUpdateZoom(newZoom, .changed)
////
////      }
////      .onEnded { value in
////
////        let finalZoom = effectiveZoom(value)
////
////        //        internalZoom = finalZoom
////        externalZoom?.wrappedValue = Double(finalZoom)
////        initialZoom = nil
////        internalZoom = didUpdateZoom(finalZoom, .ended) ?? finalZoom
////      }
//  }
//}
//extension ZoomModifier {
//  private func effectiveZoom(_ value: MagnifyGesture.Value) -> CGFloat {
//    guard let initialZoom else { return internalZoom }
//    return max(0.1, initialZoom * value.magnification)
//  }
//}
//extension View {
//
//  /// Stateful + binding sync
//  public func zoomGesture(
//    zoom: Binding<Double>,
//    isEnabled: Bool = true,
//    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
//  ) -> some View {
//    self.modifier(
//      ZoomModifier(
//        initial: CGFloat(zoom.wrappedValue),
//        zoom: zoom,
//        isEnabled: isEnabled,
//        didUpdateZoom: didUpdateZoom
//      )
//    )
//  }
//
//  /// Pure internal state + callback
//  public func zoomGesture(
//    initial: CGFloat,
//    isEnabled: Bool = true,
//    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
//  ) -> some View {
//    self.modifier(
//      ZoomModifier(
//        initial: initial,
//        zoom: nil,
//        isEnabled: isEnabled,
//        didUpdateZoom: didUpdateZoom
//      )
//    )
//  }
//}
