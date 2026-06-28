//
//  AppKitTrackingSlider.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit

final class TrackingSlider: NSSlider {
  var onEditingChanged: ((Bool) -> Void)?

  override func mouseDown(with event: NSEvent) {
    onEditingChanged?(true)
    defer { onEditingChanged?(false) }
    super.mouseDown(with: event)
  }

  override func keyDown(with event: NSEvent) {
    onEditingChanged?(true)
    defer { onEditingChanged?(false) }
    super.keyDown(with: event)
  }
}

#endif
