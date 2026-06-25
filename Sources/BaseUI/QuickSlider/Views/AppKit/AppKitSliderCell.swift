//
//  AppKitSliderCell.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit

final class AppKitSliderCell: NSSliderCell {
  var track = AppKitSliderTrack(layers: [])
  var drawsTrack = true
  var drawsThumb = true
  
  override func drawBar(inside rect: NSRect, flipped: Bool) {
    guard drawsTrack else { return }
    track.draw(in: rect)
  }
  
  override func drawKnob(_ knobRect: NSRect) {
    guard drawsThumb else { return }
    super.drawKnob(knobRect)
  }
}

#endif
