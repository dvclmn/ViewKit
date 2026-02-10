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

extension SliderComponents {
  public var columnCount: Int {
    /// Help text is vertical-only; ignore it for horizontal layout.
    let hasLabel = contains(.label)
    let hasUnits = contains(.units)
    let hasTrack = contains(.track)

    /// Track (with or without thumb) occupies a single column.
    guard hasTrack else {
      /// No track: fall back to counting visible horizontal components.
      /// Keep a sensible minimum of 1 to avoid zero-column layouts.
      let count = (hasLabel ? 1 : 0) + (hasUnits ? 1 : 0)
      return max(count, 1)
    }
    /// Base 1 column for the track, plus optional label and units.
    var count = 1
    if hasLabel { count += 1 }
    if hasUnits { count += 1 }
    return max(count, 1)
  }
}

public enum SliderPhase {
  case dragging
  case idle

  public init(fromOnEditingChanged editingDidChange: Bool) {
    self = editingDidChange ? .dragging : .idle
  }
}
