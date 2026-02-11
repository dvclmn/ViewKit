//
//  PickerComponents.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

public struct ColourPickerComponents: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int

  public static let square = Self(rawValue: 1 << 0)
  public static let hsvSliders = Self(rawValue: 1 << 1)
  public static let rgbSliders = Self(rawValue: 1 << 2)
  public static let all: Self = [.square, .hsvSliders, .rgbSliders]
}
