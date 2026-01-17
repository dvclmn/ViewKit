//
//  Representable.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

#if canImport(AppKit)
import SwiftUI

//public typealias TouchesUpdate = ([TouchPoint]) -> Void
public typealias TouchesUpdate = (Set<TouchPoint>) -> Void
public typealias PressureUpdate = (CGFloat) -> Void

struct TrackpadTouchesView: NSViewRepresentable {

  /// This will invoke the cursor hiding and freezing
  @Binding var isDrawingEnabled: Bool
  var didUpdateTouches: TouchesUpdate
  var didUpdatePressure: PressureUpdate

  public func makeNSView(context: Context) -> TrackpadTouchesNSView {
    let view = TrackpadTouchesNSView()
    // Hook up callbacks to coordinator
    view.onTouchesChanged = { [weak context] touches in
      context?.coordinator.handleTouches(touches)
    }
    view.onPressureChanged = { [weak context] pressure in
      context?.coordinator.handlePressure(pressure)
    }
    // Initialize state
    view.setDrawingMode(isActive: context.coordinator.isDrawingEnabled.wrappedValue)
    return view
//    let view = TrackpadTouchesNSView(
//      isDrawingEnabled: isDrawingEnabled,
//      didUpdateTouches: didUpdateTouches,
//      didUpdatePressure: didUpdatePressure
//    )
//    return view
  }

  public func updateNSView(_ nsView: TrackpadTouchesNSView, context: Context) {

    /// Forward changes from SwiftUI to the NSView
    nsView.setDrawingMode(isActive: isDrawingEnabled)
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(
      isDrawingEnabled: $isDrawingEnabled,
      didUpdateTouches: didUpdateTouches,
      didUpdatePressure: didUpdatePressure)
  }
}
#endif

extension TrackpadTouchesView {
  final class Coordinator {
    var isDrawingEnabled: Binding<Bool>
    let didUpdateTouches: TouchesUpdate
    let didUpdatePressure: PressureUpdate

    init(
      isDrawingEnabled: Binding<Bool>,
      didUpdateTouches: @escaping TouchesUpdate,
      didUpdatePressure: @escaping PressureUpdate
    ) {
      self.isDrawingEnabled = isDrawingEnabled
      self.didUpdateTouches = didUpdateTouches
      self.didUpdatePressure = didUpdatePressure
    }

    func handleTouches(_ touches: Set<TouchPoint>) {
      didUpdateTouches(touches)
    }

    func handlePressure(_ pressure: CGFloat) {
      didUpdatePressure(pressure)
    }
  }
}
