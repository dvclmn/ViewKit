//
//  Representable.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

#if canImport(AppKit)
import SwiftUI

public typealias TouchesUpdate = (Set<TouchPoint>) -> Void
public typealias PressureUpdate = (CGFloat) -> Void

struct TrackpadTouchesView: NSViewRepresentable {

  var didUpdateTouches: TouchesUpdate
  var didUpdatePressure: PressureUpdate

  public func makeNSView(context: Context) -> TrackpadTouchesNSView {
    let view = TrackpadTouchesNSView(
      didUpdateTouches: didUpdateTouches,
      didUpdatePressure: didUpdatePressure
    )
    return view
  }

  public func updateNSView(_ nsView: TrackpadTouchesNSView, context: Context) {}
}
#endif
