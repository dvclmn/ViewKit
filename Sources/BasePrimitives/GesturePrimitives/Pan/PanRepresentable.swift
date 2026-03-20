//
//  PanRepresentable.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import SwiftUI

public struct SwipeGestureView: NSViewRepresentable {
  let onSwipeGesture: SwipeOutput
  
  public init(_ onSwipeGesture: @escaping SwipeOutput) {
    self.onSwipeGesture = onSwipeGesture
  }

  public func makeNSView(context: Context) -> SwipeTrackingNSView {
    let view = SwipeTrackingNSView()
    view.onSwipeGesture = { event in
      self.onSwipeGesture(event)
    }
    return view
  }

  public func updateNSView(_ nsView: SwipeTrackingNSView, context: Context) {}
}
#endif
