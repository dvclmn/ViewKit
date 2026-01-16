//
//  TouchesNSView.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

import AppKit
import CoreTools

/// The underlying AppKit NSView that captures raw trackpad touches
public class TrackpadTouchesNSView: NSView {

  /// Touch manager to handle touch tracking and velocity calculation
  private let touchManager = TrackpadTouchManager()

  let isDrawingEnabled: Bool
  let didUpdateTouches: TouchesUpdate
  let didUpdatePressure: PressureUpdate

  private var latestPressure: CGFloat = 1.0

    public init(
      isDrawingEnabled: Bool,
      didUpdateTouches: @escaping TouchesUpdate,
      didUpdatePressure: @escaping PressureUpdate
    ) {
      self.isDrawingEnabled = isDrawingEnabled
      self.didUpdateTouches = didUpdateTouches
      self.didUpdatePressure = didUpdatePressure
      super.init(frame: .zero)
      self.setupView()
    }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setDrawingMode(active: Bool) {
    if active {
      NSCursor.hide()
      CGAssociateMouseAndMouseCursorPosition(false)
    } else {
      NSCursor.unhide()
      CGAssociateMouseAndMouseCursorPosition(true)
    }
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
    //    guard event.modifierFlags.contains(.option) else { return }

    //    DebugString {
    //      Labeled("Event type", value: event.type)
    //      Labeled("Event location", value: event.locationInWindow)
    //    }

    let nsTouches = event.allTouches()

    let processedTouches = touchManager.processCapturedTouches(
      nsTouches,
      timestamp: event.timestamp,
      in: .view(frame.size),
    )

    didUpdateTouches(processedTouches)

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
  public override func pressureChange(with event: NSEvent) {
    didUpdatePressure(CGFloat(event.pressure))
  }
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
