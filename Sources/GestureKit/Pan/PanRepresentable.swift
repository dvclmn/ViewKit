//
//  PanRepresentable.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import SwiftUI
import CoreTools

public struct PanGestureView: NSViewRepresentable {
  let onPanGesture: PanOutput

  public func makeNSView(context: Context) -> PanTrackingNSView {
    let view = PanTrackingNSView()
    view.didUpdatePan = { delta, phase in
      onPanGesture(delta, phase)
    }
    return view
  }

  public func updateNSView(_ nsView: PanTrackingNSView, context: Context) {}
}
#endif
