//
//  Handler+Thumb.swift
//  BaseComponents
//
//  Created by Dave Coleman on 24/8/2025.
//

import SwiftUI

public struct ThumbHandler {
  var thumbDiameter: CGFloat = 16.0
//  var sliderRange: ClosedRange<CGFloat> = 0...1

  //  public init(
  //    thumbDiameter: CGFloat = 16,
  //    sliderRange: ClosedRange<CGFloat>,
  //  ) {
  //    self.thumbDiameter = thumbDiameter
  //    self.sliderRange = sliderRange
  //  }
}

extension ThumbHandler {

  public func thumbPosition(
    forSliderValue value: CGFloat,
    range: ClosedRange<CGFloat>,
    trackSize: CGSize
  ) -> CGPoint? {

    guard trackSize.isGreaterThanZero else { return nil }
    //    guard isGeometryReady else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised: CGFloat = value.normalised(in: range)

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
