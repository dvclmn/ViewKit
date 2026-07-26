//
//  Model+AreaToMask.swift
//  BaseComponents
//
//  Created by Dave Coleman on 22/5/2025.
//

import SwiftUI

public struct ScrollMaskArea: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let start = Self(rawValue: 1 << 0)
  public static let end = Self(rawValue: 1 << 1)
  public static let all: Self = [.start, .end]
}
