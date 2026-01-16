//
//  TouchesNSView.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

import AppKit

/// The underlying AppKit NSView that captures raw trackpad touches
public class TrackpadTouchesNSView: NSView {

  /// Touch manager to handle touch tracking and velocity calculation
  private let touchManager = TrackpadTouchManager()

  let didUpdateTouches: TouchesUpdate
  let didUpdatePressure: PressureUpdate

  private var latestPressure: CGFloat = 1.0

  public init(
    didUpdateTouches: @escaping TouchesUpdate,
    didUpdatePressure: @escaping PressureUpdate
  ) {
    self.didUpdateTouches = didUpdateTouches
    self.didUpdatePressure = didUpdatePressure
    super.init(frame: .zero)
    self.setupView()
  }

  required init?(coder: NSCoder) {
    self.didUpdateTouches = { _ in }
    self.didUpdatePressure = { _ in }
    super.init(coder: coder)
  }

  private func setupView() {
    /// Direct == touches made directly onto a screen, like a Wacom
    /// Indirect == touches made on a device like a trackpad
    allowedTouchTypes = [.indirect]

    
//    self.pressureConfiguration = NSPressureConfiguration(pressureBehavior: .primaryGeneric)

    /// Include stationary touches in the updates
    wantsRestingTouches = true

  }

  private func processTouches(with event: NSEvent) {

    /// What if I require option to be held?
    guard event.modifierFlags.contains(.option) else { return }
    
    /// My gut says this should be enough to handle pressure right here.
    /// Rather than trying to squeeze it in every touch event
    didUpdatePressure(CGFloat(event.pressure))
    
    // Use matching: .any to ensure we track touches even when they start resting
    let nsTouches = event.touches(matching: .any, in: self)
    
    let processedTouches = touchManager.processCapturedTouches(
      nsTouches,
      timestamp: event.timestamp,
      in: self // Pass the view for coordinate conversion
    )
    
    didUpdateTouches(processedTouches)
//
//    let nsTouches = event.allTouches()
//
//    let processedTouches = touchManager.processCapturedTouches(
//      nsTouches,
//      timestamp: event.timestamp,
//    )
//    
//    didUpdateTouches(processedTouches)

  }

  // MARK: - Touch Event Handlers
  public override func touchesBegan(with event: NSEvent) {
    processTouches(with: event)
  }
  public override func touchesMoved(with event: NSEvent) {
    processTouches(with: event)
  }
  public override func touchesEnded(with event: NSEvent) {
    processTouches(with: event)
  }
  public override func touchesCancelled(with event: NSEvent) {
    processTouches(with: event)
  }
//  public override func pressureChange(with event: NSEvent) {
//    latestPressure = CGFloat(event.pressure)
//  }
}

extension NSTouch {
  func debuggingString(
    timestamp: TimeInterval,
    pressure: CGFloat
  ) -> String {
    """
    ////
    Received `NSTouch`
      - Phase: \(self.phase)
      - ID: \(self.identity)
      - ID Hash: \(self.identity.hash)
      - Is Resting: \(self.isResting)
      - Device: \(self.device.debugDescription)
      - Device Size: \(self.deviceSize)

      From NSEvent:
      - Timestamp: \(timestamp)
      - Pressure: \(pressure)
    """
  }
}
