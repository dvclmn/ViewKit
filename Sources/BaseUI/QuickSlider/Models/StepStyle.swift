//
//  StepStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/2/2026.
//

/// Chooses how a stepped ``QuickSlider`` supplements its native slider.
public enum StepStyle {
  /// Use only the platform's native stepped-slider appearance.
  case native
  /// Add a linked native `Stepper` beside the slider.
  case stepper
}
