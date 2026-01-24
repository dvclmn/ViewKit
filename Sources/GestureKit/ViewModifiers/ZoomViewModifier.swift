//
//  ZoomViewModifier.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreTools
import SwiftUI

public typealias ZoomUpdate = (CGFloat, InteractionPhase) -> Void
public struct ZoomModifier: ViewModifier {
  @Environment(\.canvasZoomRange) private var zoomRange
  @GestureState private var magnification: CGFloat = 1
  @State private var initialZoom: CGFloat?
  @State private var internalZoom: CGFloat   // <- source of truth
  
  private let externalZoom: Binding<Double>? // <- optional
  let isEnabled: Bool
  let didUpdateZoom: ZoomUpdate
  
//  @Environment(\.canvasZoomRange) private var zoomRange
//  @GestureState private var magnification: CGFloat = 1
//  @State private var initialZoom: CGFloat?
//
//  @Binding var zoom: Double
//  let isEnabled: Bool
//
//  /// Handy to have this, for some use cases
//  let didUpdateZoom: ZoomUpdate

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
          initialZoom = internalZoom   // <- always valid
        }
        
        let newZoom = effectiveZoom(value)
        
        internalZoom = newZoom
        externalZoom?.wrappedValue = Double(newZoom) // optional sync
        didUpdateZoom(newZoom, .changed)
        
        
        
//        if initialZoom == nil {
//          initialZoom = zoom
//        }
//
//        let newZoom = effectiveZoom(value)
//        zoom = newZoom
//        didUpdateZoom(newZoom, .changed)
      }
      .onEnded { value in
//        initialZoom = nil
//        didUpdateZoom(effectiveZoom(value), .ended)
        
        let finalZoom = effectiveZoom(value)
        
        internalZoom = finalZoom
        externalZoom?.wrappedValue = Double(finalZoom)
        initialZoom = nil
        didUpdateZoom(finalZoom, .ended)
      }
  }
}
extension ZoomModifier {
  private func effectiveZoom(_ value: MagnifyGesture.Value) -> CGFloat {
    guard let initialZoom else { return internalZoom }
    return initialZoom * value.magnification
  }
}
extension View {
  
  // Stateful + binding sync
  public func zoomGesture(
    zoom: Binding<Double>,
    isEnabled: Bool = true,
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in }
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
    didUpdateZoom: @escaping ZoomUpdate = { _, _ in }
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
//  public func zoomGesture(
//    zoom: Binding<Double>,
//    isEnabled: Bool = true,
//  ) -> some View {
//    self.modifier(
//      ZoomModifier(
//        zoom: zoom,
//        isEnabled: isEnabled,
//        didUpdateZoom: { _, _ in }
//      )
//    )
//  }
//
//  public func zoomGesture(
//    initial: CGFloat,
//    isEnabled: Bool = true,
//    didUpdateZoom: @escaping ZoomUpdate = { _, _ in }
//  ) -> some View {
//    self.modifier(
//      ZoomModifier(
//        zoom: .constant(initial),
//        isEnabled: isEnabled,
//        didUpdateZoom: didUpdateZoom
//      )
//    )
//  }
}
