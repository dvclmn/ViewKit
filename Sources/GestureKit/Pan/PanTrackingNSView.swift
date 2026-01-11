//
//  PanGestureNSView.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import AppKit
import CoreTools

// MARK: - Custom NSView for Pan Tracking
public class PanTrackingNSView: NSView {

  var didUpdatePan: PanGestureOutput = { _ in }

//  public init(
//    didUpdatePanGesture: @escaping PanGestureOutput
//  ) {
//    self.didUpdatePan = didUpdatePanGesture
//    super.init(frame: .zero)
//  }
//  
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }


  // MARK: - Two-Finger Pan via ScrollWheel
  public override func scrollWheel(with event: NSEvent) {
    guard event.hasPreciseScrollingDeltas else { return }
    let deltaX = event.scrollingDeltaX
    let deltaY = event.scrollingDeltaY
    let delta = CGSize(width: deltaX, height: deltaY)

//    print("Can NSEvent's Phase be more than one value simultaneously?")
//    print("Current delta: \(delta)")
//    print("NSEvent Phase: \(event.phase)")
//    print("NSEvent Momentum Phase: \(event.momentumPhase)\n\n")

    let phase = InteractionPhase(from: event.momentumPhase)
    let state = PanState(offset: delta, phase: phase)

    didUpdatePan(state)
  }

//  public override func mouseExited(with event: NSEvent) {
//    print("Mouse exited with event: \(event)")
//    super.mouseExited(with: event)
//    didUpdatePan(.inactive)
//  }
}
#endif
