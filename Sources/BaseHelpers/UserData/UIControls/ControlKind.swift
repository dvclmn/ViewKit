//
//  ControlKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

/// ```
/// struct Synth: Controllable {
///   var amplitude: Double = 0.5
///   var isEnabled: Bool = true
///
///   static var controls: [AnyControlDescriptor<Synth>] {
///     [
///       ControlDescriptor(
///         keyPath: \.amplitude,
///         kind: .slider,
///         title: "Amplitude",
///         range: 0.0...1.0,
///         layout: .section(.standard),
///         toggleConfig: .noToggle
///       )
///       .erase(),
///
///       ControlDescriptor(
///         keyPath: \.isEnabled,
///         kind: .toggle,
///         title: "Enabled",
///         layout: .section(.disclosure),
///         toggleConfig: .togglable(default: true)
///       )
///       .erase()
///     ]
///   }
/// }
/// ```
public protocol Controllable {
  static var controls: [AnyControlDescriptor<Self>] { get }
}

public enum ControlKind {
  case slider
  case toggle
  case picker
  case scrubber
//  case hsvSliders
//  case waveControls
}

struct LayoutConfiguration {
  let kind: LayoutKind
  let toggleConfig: ToggleConfig
}

public enum ToggleConfig {
  case togglable(default: Bool)
  case noToggle // Always enabled
}

public enum LayoutKind {
  case groupBox
  case section(SectionKind)
//  case toggled
//  case sliderGroup
}

public enum SectionKind {
  case disclosure
  case standard
}

