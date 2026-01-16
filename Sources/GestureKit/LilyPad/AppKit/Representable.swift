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

public struct TrackpadTouchesView: NSViewRepresentable {

  private var onTouchesUpdate: TouchesUpdate?
  private var onPressureUpdate: PressureUpdate?

  public init(onTouchesUpdate: TouchesUpdate? = nil) {
    self.onTouchesUpdate = onTouchesUpdate
  }

  public func makeNSView(context: Context) -> TrackpadTouchesNSView {
    let view = TrackpadTouchesNSView { touchOutput in
      onTouchesUpdate?(touchOutput)
    }
    return view
  }

  public func updateNSView(_ nsView: TrackpadTouchesNSView, context: Context) {}
}
#endif
