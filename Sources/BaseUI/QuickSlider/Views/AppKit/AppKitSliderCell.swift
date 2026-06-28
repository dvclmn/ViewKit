//
//  AppKitSliderCell.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit

final class AppKitSliderCell: NSSliderCell {
  var track = AppKitSliderTrack(layers: [])
  var drawsTrack = true
  var drawsThumb = true
  var horizontalVisualOverflow: CGFloat = 0

  override func barRect(flipped: Bool) -> NSRect {
    let rect = super.barRect(flipped: flipped)
    guard rect.width > horizontalVisualOverflow * 2 else { return rect }

    return rect.insetBy(dx: horizontalVisualOverflow, dy: 0)
  }

  override func knobRect(flipped: Bool) -> NSRect {
    var rect = super.knobRect(flipped: flipped)
    guard
      horizontalVisualOverflow > 0,
      let controlView,
      maxValue > minValue
    else { return rect }

    let bounds = controlView.bounds
    let rawProgress = (doubleValue - minValue) / (maxValue - minValue)
    let progress = min(max(rawProgress, 0), 1)
    let minX = bounds.minX + horizontalVisualOverflow
    let maxX = max(minX, bounds.maxX - horizontalVisualOverflow - rect.width)

    rect.origin.x = minX + ((maxX - minX) * CGFloat(progress))
    return rect
  }

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
