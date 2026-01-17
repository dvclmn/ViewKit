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
  // Opt into first responder so we can receive key events (e.g., Esc) and ensure focus during drawing
  //  public override var acceptsFirstResponder: Bool { true }
  //  public override func becomeFirstResponder() -> Bool { true }
  //  public override func resignFirstResponder() -> Bool { true }

  /// Touch manager to handle touch tracking and velocity calculation
  private let touchManager = TrackpadTouchManager()

  private(set) var isDrawingEnabled: Bool
  //  let isDrawingEnabled: Bool
  let didUpdateTouches: TouchesUpdate
  let didUpdatePressure: PressureUpdate

  private var latestPressure: CGFloat = 1.0

  //  private func disableDrawingMode()
  //  {
  //    guard isDrawingEnabled else { return }
  //    setDrawingMode(isActive: false)
  //  }

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

    // Initialization complete
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //  public override func viewDidMoveToWindow() {
  //    super.viewDidMoveToWindow()
  //    // Try to become first responder once we're in a window so key/touch events route here
  //    self.window?.makeFirstResponder(self)
  //  }

  public func setDrawingMode(isActive: Bool) {
    guard isActive != isDrawingEnabled else {
      return
    }
    print("Running `setDrawingMode`. Drawing mode was \(isDrawingEnabled), is now \(isActive).")
    isDrawingEnabled = isActive

    //        if isActive {
    // Ensure this view is the first responder so it receives touch and key events
    //          self.window?.makeFirstResponder(self)
    //
    //          print("Info: \(self.becomeFirstResponder())")
    //
    //          print("Hiding the pointer")
    //          NSCursor.hide()
    //          CGWarpMouseCursorPosition(frame.midpoint)
    //          CGAssociateMouseAndMouseCursorPosition(0)

    //        } else {
    //          print("Showing the pointer")
    //          NSCursor.unhide()
    //          CGAssociateMouseAndMouseCursorPosition(1)

    //        }

    // Do any other "xyz" side effects here, e.g.:
    // - adjust pressure configuration
    // - reset touch manager state
    // - change tracking areas or gesture recognizers
  }

  //  func setDrawingMode(active: Bool) {
  //    if active {
  //      NSCursor.hide()
  //      CGAssociateMouseAndMouseCursorPosition(false)
  //    } else {
  //      NSCursor.unhide()
  //      CGAssociateMouseAndMouseCursorPosition(true)
  //    }
  //  }

  private func setupView() {
    /// Direct == touches made directly onto a screen, like a Wacom
    /// Indirect == touches made on a device like a trackpad
    allowedTouchTypes = [.indirect]

    //    self.pressureConfiguration = NSPressureConfiguration(pressureBehavior: .primaryGeneric)

    /// Include stationary touches in the updates
    wantsRestingTouches = true

    pressureConfiguration = NSPressureConfiguration(pressureBehavior: .primaryGeneric)
    pressureConfiguration?.set()

  }

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

    didUpdateTouches(processedTouches)
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

  private func processPressureChange(with event: NSEvent) {
    let pressure = CGFloat(event.pressure)
    //    DebugString {
    //      Labeled("Pressure amount", value: pressure)
    //      Labeled("Pressure stage", value: event.stage)
    //      Labeled("Pressure stage transition", value: event.stageTransition)
    //    }
    didUpdatePressure(pressure)
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
