//
//  ControlKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/2/2026.
//

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

