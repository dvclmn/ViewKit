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
  
  var lastKnownDrawingMode: Bool = false
  var onTouchesChanged: TouchesUpdate
  var onPressureChanged: PressureUpdate

  /// Touch manager to handle touch tracking and velocity calculation
  private let touchManager = TrackpadTouchManager()

  public init(
    _ onTouchesChanged: @escaping TouchesUpdate,
    _ onPressureChanged: @escaping PressureUpdate
  ) {
    self.onTouchesChanged = onTouchesChanged
    self.onPressureChanged = onPressureChanged
    super.init(frame: .zero)
    self.setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Called from SwiftUI's updateNSView whenever the binding changes.
  public func setDrawingMode(isActive: Bool) {
    if isActive {
//      print("Hiding the pointer via AppKit")
//      CGWarpMouseCursorPosition(frame.midpoint)
      CGAssociateMouseAndMouseCursorPosition(0)
      NSCursor.hide()

    } else {
//      print("Showing the pointer via AppKit")
      CGAssociateMouseAndMouseCursorPosition(1)
      NSCursor.unhide()

    }
    // Update pressure, reset touch manager, etc.
  }

  private func setupView() {
    /// Direct == touches made directly onto a screen, like a Wacom
    /// Indirect == touches made on a device like a trackpad
    allowedTouchTypes = [.indirect]

    /// Include stationary touches in the updates
    wantsRestingTouches = true

    pressureConfiguration = NSPressureConfiguration(pressureBehavior: .primaryGeneric)
    pressureConfiguration?.set()

  }

  // MARK: - Events

  private func processTouches(with event: NSEvent) {

    /// What if I require option to be held?
    //    guard event.modifierFlags.contains(.option) else { return }

    //    debugEventStream(event)

    let nsTouches = event.allTouches()

    let processedTouches = touchManager.processCapturedTouches(
      nsTouches,
      timestamp: event.timestamp,
      in: .view(frame.size),
    )

    onTouchesChanged(processedTouches)
  }

  private func processPressureChange(with event: NSEvent) {
    let pressure = CGFloat(event.pressure)
    //    DebugString {
    //      Labeled("Pressure amount", value: pressure)
    //      Labeled("Pressure stage", value: event.stage)
    //      Labeled("Pressure stage transition", value: event.stageTransition)
    //    }
    onPressureChanged(pressure)
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
    processPressureChange(with: event)
  }

  private func debugEventStream(_ event: NSEvent) {
    /// Properties that I know produce the assertion failures:
    /// `event.associatedEventsMask`
    DebugString {
      Indented("Event information") {
        //        Labeled("Phase", value: event.phase)
        //        Labeled("Momentum phase", value: event.momentumPhase)
        //        Labeled("Type", value: event.type)
        //        Labeled("Sub-type", value: event.subtype)
        Labeled("Location", value: event.locationInWindow)
        //        Labeled("Window", value: event.window)

      }
    }
  }

  //  public override func keyDown(with event: NSEvent) {
  //    /// 53 is the virtual key code for Escape.
  //    /// Also check charactersIgnoringModifiers for robustness.
  //    if event.keyCode == 53 || event.charactersIgnoringModifiers == String(UnicodeScalar(27)) {
  //      setDrawingMode(isActive: false)
  //      return
  //    }
  //    super.keyDown(with: event)
  //  }

  //  public override func acceptsFirstMouse(for event: NSEvent?) -> Bool { true }
}
