//
//  Handler+SliderDrag.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import CoreTools
import SwiftUI
import ViewTools

@Observable
final class SliderHandler {

  var label: LabelDescriptor
  var range: ClosedRange<Double>
  var step: Double?

  var phase: SliderPhase = .idle
  var didChangeSlider: SliderOutput?

  var trackWidth: Double?

  let thumbDiameter: Double = 16
  let trackHeight: Double = 5
  let hitAreaBuffer: Double = 16

  /// May be provided by user, if used where access to GridKit is available
  var characterSize: CGSize?

  let width: Int = 30
  let cellCharacters = ["░", "▒", "▓", "█"]

  init(
    label: LabelDescriptor,
    range: ClosedRange<Double>,
    step: Double?,
    characterSize: CGSize?,
    //    minMaxLabels: (String, String)?,
    didChangeSlider: SliderOutput?,
  ) {
    self.label = label
    self.range = range
    self.step = step
    self.characterSize = characterSize
    //    self.minMaxLabels = minMaxLabels
    self.didChangeSlider = didChangeSlider
  }
}

extension SliderHandler {
  var characterSizeWithFallback: CGSize {
    // TODO: Need to dial this in
    let fallback = CGSize(width: 20, height: 30)
    return characterSize ?? fallback
  }
  var sliderTrackColumns: Int { width - 2 }

  func trackConfiguration(
    value: Double,
    colourScheme: ColorScheme,
      //    in env: EnvironmentValues
  ) -> SliderTrackConfiguration {
    .init(
      value: value,
      range: range,
      colorScheme: colourScheme,
      tint: .accentColor,
    )
  }

  var trackSizeWithHeightBuffer: CGSize? {
    guard let trackWidth else { return nil }
    return CGSize(width: trackWidth, height: trackHeightWithBuffer)
  }

  var trackHeightWithBuffer: Double { trackHeight + hitAreaBuffer }

  var isDragging: Bool { phase == .dragging }

  private var isGeometryReady: Bool { trackWidth != nil }
  //  private var isGeometryReady: Bool { trackSize.isGreaterThanZero }

  /// Do not include the hit area buffer in `trackHeight`
  func updateTrackSize(viewWidth: Double) {
    //    let heightIncBuffer: Double = trackHeight + hitAreaBuffer
    trackWidth = viewWidth
    //    trackSize = CGSize(width: viewWidth, height: heightIncBuffer)
  }

  func updatePhase(_ phase: SliderPhase) {
    self.phase = phase
    self.didChangeSlider?(phase)
  }

  func handleDragChange(
    _ gestureValue: DragGesture.Value
  ) -> Double? {

    //    print("Handling drag change")
    /// fall back to current value
    guard let trackWidth else {
      //      print("No value for track width")
      return nil
    }
    //    guard trackWidth > 0 else { return nil }

    let location = gestureValue.location.x

    /// Location clamped so it cannot go outside
    /// the bounds of the track
    let clamped = location.clamped(0, trackWidth)
    let percentage = Double(clamped / trackWidth)
    let newValue = percentage.denormalised(in: range)

    return newValue
  }

  func fillWidth(_ value: Double) -> Double? {

    //    guard isGeometryReady else { return nil }
    guard let trackWidth else { return nil }

    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised = value.normalised(in: range)
    return normalised * trackWidth
  }

  public func thumbPosition(
    value: Double
    //    diameter: Double,
    //    trackSize: CGSize
  ) -> CGPoint? {

    //    guard trackSize.isGreaterThanZero else { return nil }
    //    guard isGeometryReady else { return nil }
    guard let trackWidth else { return nil }
    /// Normalised here is essentially: “How far along the slider should the
    /// thumb be, in proportion to its full track length?”
    let normalised = value.normalised(in: range)

    /// Remove some length from the beginning/end of the draggable width,
    /// so the Thumb doesn't hand awkwardly out the edges of the track.

    let horizontalPadding = thumbDiameter * 0.4
    let adjustedWidth = max(0, trackWidth - (horizontalPadding * 2))

    let x = CGFloat(horizontalPadding + (normalised * adjustedWidth))
    let y = trackHeightWithBuffer / 2

    return CGPoint(x: x, y: y)
  }

}
