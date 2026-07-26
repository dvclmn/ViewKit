//
//  Handler+Slider.swift
//  ViewKit
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI

/// Holds the transient interaction state for one ``QuickSlider`` identity.
///
/// The handler deliberately does not own the binding or its presentation
/// configuration. Those are value inputs to `QuickSlider`, so SwiftUI can
/// supply their current values whenever it updates the view. Keeping only the
/// editing phase here avoids retaining stale ranges, labels, or callbacks when
/// a parent recreates the slider value.
@Observable
final class SliderHandler {
  private(set) var phase: SliderPhase = .idle

  /// Records a genuine editing transition and notifies the current callback.
  func updatePhase(
    _ phase: SliderPhase,
    didChangeSlider: SliderOutput,
  ) {
    guard phase != self.phase else { return }

    self.phase = phase
    didChangeSlider(phase)
  }
}
