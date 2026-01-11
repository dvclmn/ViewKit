//
//  PanRepresentable.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import SwiftUI
import CoreTools

public typealias PanGestureOutput = (CGSize, InteractionPhase) -> Void
//public typealias PanGestureOutput = (PanPhase) -> Void

// MARK: - SwiftUI Representable
public struct PanGestureView: NSViewRepresentable {
//  @Binding var handler: PanGestureHandler
  let onPanGesture: PanGestureOutput

//  public init(onPanGesture: @escaping PanGestureOutput) {
//    
//    self.onPanGesture = onPanGesture
//  }

  public func makeNSView(context: Context) -> PanTrackingNSView {
    let view = PanTrackingNSView()
    view.didUpdatePan = { offset, phase in
      onPanGesture(offset, phase)
    }

    return view
  }

  public func updateNSView(_ nsView: PanTrackingNSView, context: Context) {}
}
#endif
