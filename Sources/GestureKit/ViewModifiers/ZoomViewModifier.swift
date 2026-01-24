//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

public typealias ZoomUpdate = (CGFloat, InteractionPhase) -> CGFloat?
//public typealias ZoomUpdate = (CGFloat, InteractionPhase) -> Void
public struct ZoomModifier: ViewModifier {
  @Environment(\.canvasZoomRange) private var zoomRange
  @Environment(\.modifierKeys) private var modifierKeys

  @GestureState private var magnification: CGFloat = 1
  @State private var initialZoom: CGFloat?
  @State private var internalZoom: CGFloat  // <- source of truth

  private let externalZoom: Binding<Double>?  // <- optional
  let isEnabled: Bool
  let didUpdateZoom: ZoomUpdate

  init(
    initial: CGFloat,
    zoom: Binding<Double>? = nil,
    isEnabled: Bool,
    didUpdateZoom: @escaping ZoomUpdate
  ) {
    self._internalZoom = State(initialValue: initial)
    self.externalZoom = zoom
    self.isEnabled = isEnabled
    self.didUpdateZoom = didUpdateZoom
  }

  public func body(content: Content) -> some View {
    content
      .simultaneousGesture(zoomGesture, isEnabled: isEnabled)
      .onChange(of: modifierKeys) {
        initialZoom = nil
      }
  }
}
extension ZoomModifier {

  private var zoomGesture: some Gesture {
    MagnifyGesture()
      .updating($magnification) { value, state, _ in
        state = value.magnification
      }
      .onChanged { value in

        if initialZoom == nil {
          initialZoom = internalZoom  // <- always valid
        }

        let newZoom = effectiveZoom(value)
        //        let newZoom = effectiveZoom(value).clampedIfNeeded(to: zoomRange)

        internalZoom = newZoom
        externalZoom?.wrappedValue = Double(newZoom)  // optional sync
        _ = didUpdateZoom(newZoom, .changed)

      }
      .onEnded { value in

        let finalZoom = effectiveZoom(value)

        //        internalZoom = finalZoom
        externalZoom?.wrappedValue = Double(finalZoom)
        initialZoom = nil
        internalZoom = didUpdateZoom(finalZoom, .ended) ?? finalZoom
      }
  }
}
extension ZoomModifier {
  private func effectiveZoom(_ value: MagnifyGesture.Value) -> CGFloat {
    guard let initialZoom else { return internalZoom }
    return max(0.1, initialZoom * value.magnification)
  }
}
extension View {

  // Stateful + binding sync
  public func zoomGesture(
    zoom: Binding<Double>,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: CGFloat(zoom.wrappedValue),
        zoom: zoom,
        isEnabled: isEnabled,
        didUpdateZoom: didUpdateZoom
      )
    )
  }

  // Pure internal state + callback
  public func zoomGesture(
    initial: CGFloat,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in nil }
  ) -> some View {
    self.modifier(
      ZoomModifier(
        initial: initial,
        zoom: nil,
        isEnabled: isEnabled,
        didUpdateZoom: didUpdateZoom
      )
    )
  }
}
