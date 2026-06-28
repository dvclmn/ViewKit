//
//  Scrubber+Env.swift
//  ViewKit
//
//  Created by Dave Coleman on 18/1/2026.
//

import SwiftUI

extension EnvironmentValues {
  @Entry var scrubberComponents: ScrubberComponents = .all
}

extension View {
  func stepperComponents(_ components: ScrubberComponents) -> some View {
    self.environment(\.scrubberComponents, components)
  }
}

public struct ScrubberComponents: OptionSet, Sendable {
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  public let rawValue: Int
  
  public static let stepper = Self(rawValue: 1 << 0)
  public static let dragAdjustment = Self(rawValue: 1 << 1)
  public static let editableText = Self(rawValue: 1 << 2)
  public static let all: Self = [.stepper, .dragAdjustment, .editableText]
}
