//
//  PanGestureNSView.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import AppKit
import BasePrimitives

public class PanTrackingNSView: NSView {
  var didUpdatePan: PanOutput = { _, _, _ in }

  public override func scrollWheel(with event: NSEvent) {
    let modifiers = Modifiers(from: event)
    guard event.hasPreciseScrollingDeltas else { return }
    let delta = CGSize(width: event.scrollingDeltaX, height: event.scrollingDeltaY)
    
    let phase = InteractionPhase(from: event.phase)
//    let phase = InteractionPhase(from: event.momentumPhase)
//    print("Phase for pan: \(phase.name). Is Active? \(phase.isActive)")
    didUpdatePan(delta, phase, modifiers)
  }
}
#endif
