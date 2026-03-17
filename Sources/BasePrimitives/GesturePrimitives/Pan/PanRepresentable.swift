//
//  PanRepresentable.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import SwiftUI
import BasePrimitives

public struct PanGestureView: NSViewRepresentable {
  let onPanGesture: PanOutput
  
  public init(onPanGesture: @escaping PanOutput) {
    self.onPanGesture = onPanGesture
  }

  public func makeNSView(context: Context) -> PanTrackingNSView {
    let view = PanTrackingNSView()
    view.didUpdateSwipe = { delta, phase, modifiers in
      onPanGesture(delta, phase, modifiers)
    }
    return view
  }

  public func updateNSView(_ nsView: PanTrackingNSView, context: Context) {}
}
#endif
