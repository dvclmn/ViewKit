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

    let view = TrackpadTouchesNSView(
      didUpdateTouches,
      didUpdatePressure
    )
    view.setDrawingMode(isActive: isDrawingEnabled)
    return view
  }

  public func updateNSView(_ nsView: TrackpadTouchesNSView, context: Context) {

    /// Forward changes from SwiftUI to the NSView
    nsView.setDrawingMode(isActive: isDrawingEnabled)
  }
}
#endif
