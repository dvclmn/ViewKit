//
//  PanGestureNSView.swift
//  Paperbark
//
//  Created by Dave Coleman on 24/6/2025.
//

#if canImport(AppKit)
import AppKit

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
    
    /// Map `NSEvent.Phase` to `PanPhase`
//    let panPhase: PanPhase
//    switch event.phase {
//      case .began:
//        panPhase = .active(delta: delta)
////        panPhase = .active(delta: delta)
//      case .changed:
//        panPhase = .active(delta: delta)
//      case .ended:
//        panPhase = .ended(finalDelta: delta)
//      case .cancelled:
//        panPhase = .cancelled
//      default:
//        /// For stationary or other phases, may not want to trigger
//        return
//    }
    let state = PanState(offset: delta, phase: .inactive)

    didUpdatePan(state)
  }

//  public override func mouseExited(with event: NSEvent) {
//    print("Mouse exited with event: \(event)")
//    super.mouseExited(with: event)
//    didUpdatePan(.inactive)
//  }
}
#endif
