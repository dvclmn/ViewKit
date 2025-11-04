//
//  PartType+Flex.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import SwiftUI
import EnumMacros

extension Box.PartType {
  /// Whether or not this part should take on repeatable behaviour
  @CaseDetection
  public enum Flexibility: Equatable, Codable, Sendable {
    case repeatable(axis: Axis)
    case fixed
  }
}
