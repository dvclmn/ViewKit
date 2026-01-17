//
//  Slider+Model.swift
//  Components
//
//  Created by Dave Coleman on 1/11/2024.
//

import SwiftUI

public struct TrackComponents: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let fill = Self(rawValue: 1 << 0)
  public static let thumb = Self(rawValue: 1 << 1)
  public static let all: Self = [.fill, .thumb]
}

public struct SliderComponents: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let label = Self(rawValue: 1 << 0)
  public static let slider = Self(rawValue: 1 << 1)
  public static let units = Self(rawValue: 1 << 2)
  public static let all: Self = [.label, .slider, .units]
}

//public enum SliderValueFormat {
//  case plain
//  case percentage
//}

public enum SliderPhase {
  case dragging
  case idle

  public init(fromOnEditingChanged value: Bool) {
    if value {
      self = .dragging
    } else {
      self = .idle
    }
  }
}
