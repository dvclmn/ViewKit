//
//  Handler+SliderDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import BasePrimitives
import SwiftUI

@Observable
final class SliderHandler<Value: BinaryFloatingPoint & Sendable> {

  var value: Value
  var label: QuickLabel
  var range: ClosedRange<Value>
  var step: Value?
  //  var step: StepStyle<Double> = .none

  var phase: SliderPhase = .idle
  var didChangeSlider: SliderOutput?

  //  var thumbHandler: ThumbHandler = .init()

  /// Including vertical hit area buffer
  var trackSize: CGSize = .zero
  let hitAreaBuffer: Double = 16
  let fallbackHeight: Double = 5

  init(
    value: Value,
    label: QuickLabel,
    range: ClosedRange<Value>,
    step: Value?,
    //    step: StepStyle<Value>,
    didChangeSlider: SliderOutput?
  ) {
    self.value = value
    self.label = label
    self.range = range
    self.step = step
    self.didChangeSlider = didChangeSlider
  }
}

extension SliderHandler {

  var isDragging: Bool { phase == .dragging }

  private var isGeometryReady: Bool { trackSize.isGreaterThanZero }

  /// Do not include the hit area buffer in `trackHeight`
  func updateTrackSize(
    viewWidth: Double,
    trackHeight: Double
  ) {
    let heightIncBuffer: Double = trackHeight + hitAreaBuffer
    trackSize = CGSize(width: viewWidth, height: heightIncBuffer)
  }

  func updatePhase(_ phase: SliderPhase) {
    self.phase = phase
    self.didChangeSlider?(phase)
  }

  func handleDragChange(_ gestureValue: DragGesture.Value) -> Value {

    let trackWidth = Value(trackSize.width)
    /// fall back to current value
    guard trackWidth > 0 else { return value }

    let location = Value(gestureValue.location.x)

    /// Location clamped so it cannot go outside
    /// the bounds of the track
    let clamped = location.clamped(0, trackWidth)
    let percentage = clamped / trackWidth
    let newValue = percentage.denormalised(in: range)

    return newValue
  }

  func fillWidth() -> Value? {

    guard isGeometryReady else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised = value.normalised(in: range)
    return normalised * Value(trackSize.width)
  }

  public func thumbPosition(
    diameter: Value,
    trackSize: CGSize
  ) -> CGPoint? {

    guard trackSize.isGreaterThanZero else { return nil }
    //    guard isGeometryReady else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised = value.normalised(in: range)

    /// Remove some length from the beginning/end of the draggable width,
    /// so the Thumb doesn't hand awkwardly out the edges of the track.

    let horizontalPadding = diameter * 0.4
    let adjustedWidth = max(0, Value(trackSize.width) - (horizontalPadding * 2))

    let x = CGFloat(horizontalPadding + (normalised * adjustedWidth))
    let y = trackSize.height / 2

    return CGPoint(x: x, y: y)
  }

}
