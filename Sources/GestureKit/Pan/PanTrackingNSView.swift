//
//  PanGestureNSView.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import AppKit
import CoreTools

public class PanTrackingNSView: NSView {
  var didUpdatePan: PanOutput = { _, _, _ in }

  public override func scrollWheel(with event: NSEvent) {
    let modifiers = Modifiers(from: event)
    guard event.hasPreciseScrollingDeltas else { return }
    let delta = CGSize(width: event.scrollingDeltaX, height: event.scrollingDeltaY)
    let phase = InteractionPhase(from: event.momentumPhase)
    didUpdatePan(delta, phase, modifiers)
  }
}
#endif
