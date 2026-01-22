//
//  Handler+SliderDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import BasePrimitives
import SwiftUI

@Observable
final class SliderHandler {
  var value: Double
  var label: QuickLabel
  var range: ClosedRange<Double>

  var phase: SliderPhase = .idle
  var didChangeSlider: SliderOutput?
  //  var formatValue: FormatValue?

  var thumbHandler: ThumbHandler = .init()

  /// Including vertical hit area buffer
  var trackSize: CGSize = .zero
  let hitAreaBuffer: CGFloat = 16
  let fallbackHeight: CGFloat = 5

  public init(
    value: Double,
    label: QuickLabel,
    range: ClosedRange<Double>,
  ) {
    self.value = value
    self.label = label
    self.range = range
  }
}

extension SliderHandler {

  //  func updateRange() {
  //    self.range = range
  //  }
  //  func setUp(
  //    range: ClosedRange<Double>,
  //    label: QuickLabel
  //  ) {
  //    self.range = range
  //    self.label = label
  //
  //    let thumbHandler = ThumbHandler(sliderRange: range)
  //    self.thumbHandler = thumbHandler
  //  }

  //  func triggerDidChangeSlider(_ phase: SliderPhase) {
  //    didChangeSlider?(phase)
  //  }
  //  func triggerFormatValue() -> String? {
  ////  func triggerFormatValue(_ value: Double) -> String? {
  //    formatValue?(value)
  //  }

  var isDragging: Bool { phase == .dragging }

  private var isGeometryReady: Bool { trackSize.isGreaterThanZero }

  /// Do not include the hit area buffer in `trackHeight`
  func updateTrackSize(
    viewWidth: CGFloat,
    trackHeight: CGFloat
  ) {
    let heightIncBuffer: CGFloat = trackHeight + hitAreaBuffer
    trackSize = CGSize(width: viewWidth, height: heightIncBuffer)
  }

  func updatePhase(_ phase: SliderPhase) {
    self.phase = phase
    self.didChangeSlider?(phase)
  }

  func handleDragChange(_ gestureValue: DragGesture.Value) -> CGFloat {
    let location = gestureValue.location.x

    /// Location clamped so it cannot go outside
    /// the bounds of the track
    let clamped = location.clamped(0, trackSize.width)

    let percentage = clamped / trackSize.width

    let newValue = percentage.denormalised(in: range.toCGFloatRange)
    //    let newValue = range.lowerBound + (percentage * (range.upperBound - range.lowerBound))

    return newValue
  }

  func fillWidth() -> CGFloat? {

    guard isGeometryReady else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised: CGFloat = value.normalised(in: range)
    return normalised * trackSize.width
  }

  //  var thumbDiameter: CGFloat {
  //    //  func thumbDiameter(with controlSize: ControlSize) -> CGFloat {
  //    //    switch controlSize {
  //    //      case .small: return 12
  //    return 16
  //    //      default: return 16
  //    //    }
  //  }

  //  func thumbPosition(
  //    for value: CGFloat
  //  ) -> CGPoint? {
  //
  //    guard isGeometryReady else { return nil }
  //
  //    /// Normalised here is essentially: “How far along the slider should the
  //    /// thumb be, in proportion to its full track length?”
  //    let normalised: CGFloat = value.normalised(from: range)
  //
  //    /// Remove some length from the beginning/end of the draggable width,
  //    /// so the Thumb doesn't hand awkwardly out the edges of the track.
  //    let horizontalPadding: CGFloat = thumbDiameter * 0.4
  //    let adjustedWidth = trackSize.width - (horizontalPadding * 2)
  //
  //    let x = horizontalPadding + (normalised * adjustedWidth)
  //    let y = trackSize.height / 2
  //
  //    return CGPoint(x: x, y: y)
  //  }

}
