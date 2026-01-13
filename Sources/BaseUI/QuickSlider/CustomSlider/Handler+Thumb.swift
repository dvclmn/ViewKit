//
//  Handler+Thumb.swift
//  BaseComponents
//
//  Created by Dave Coleman on 24/8/2025.
//

import SwiftUI

public struct ThumbHandler {
  let thumbDiameter: CGFloat
  let sliderRange: ClosedRange<CGFloat>

  public init(
    thumbDiameter: CGFloat = 16,
    sliderRange: ClosedRange<CGFloat>,
  ) {
    self.thumbDiameter = thumbDiameter
    self.sliderRange = sliderRange
  }

  //  public mutating func updateTrackSize(_ size: CGSize) {
  //    self.trackSize = size
  //  }
  public func thumbPosition(
    forSliderValue value: CGFloat,
    trackSize: CGSize
  ) -> CGPoint? {

    guard trackSize.isGreaterThanZero else { return nil }
    //    guard isGeometryReady else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised: CGFloat = value.normalised(in: sliderRange)

    /// Remove some length from the beginning/end of the draggable width,
    /// so the Thumb doesn't hand awkwardly out the edges of the track.
    let horizontalPadding: CGFloat = thumbDiameter * 0.4
    let adjustedWidth = trackSize.width - (horizontalPadding * 2)

    let x = horizontalPadding + (normalised * adjustedWidth)
    let y = trackSize.height / 2

    return CGPoint(x: x, y: y)
  }

  //  private var isGeometryReady: Bool {
  //    trackSize.areBothDimensionsGreaterThan(.zero)
  //  }

  
}
