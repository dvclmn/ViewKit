//
//  Slider+Model.swift
//  Components
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

public struct SliderComponents: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let label = Self(rawValue: 1 << 0)
  public static let helpText = Self(rawValue: 1 << 1)
  public static let track = Self(rawValue: 1 << 2)
  public static let thumb = Self(rawValue: 1 << 3)
  public static let units = Self(rawValue: 1 << 4)

  /// Common presets
  public static let all: Self = [.label, .helpText, .track, .thumb, .units]
  public static let noLabel: Self = [.track, .thumb, .units]
  public static let noUnits: Self = [label, .track, .thumb]
}

public enum SliderPhase {
  case dragging
  case idle

  public init(fromOnEditingChanged editingDidChange: Bool) {
    self = editingDidChange ? .dragging : .idle
  }
}
