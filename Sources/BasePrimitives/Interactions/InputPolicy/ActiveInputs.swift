//
//  ActiveInputs.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation

public struct ActiveInputs: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let swipeGesture = Self(rawValue: 1 << 0)
  public static let pinchGesture = Self(rawValue: 1 << 1)
  public static let pointerHover = Self(rawValue: 1 << 2)
  public static let pointerTapGesture = Self(rawValue: 1 << 3)
  public static let pointerDragGesture = Self(rawValue: 1 << 4)
  public static let all: Self = [
    .swipeGesture,
    .pinchGesture,
    .pointerHover,
    .pointerTapGesture,
    .pointerDragGesture
  ]
}
