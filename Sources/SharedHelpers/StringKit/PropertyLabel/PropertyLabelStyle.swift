//
//  PropertyLabelStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/2/2026.
//

import EnumMacros

extension PropertyLabel {
  @CaseDetection
  public enum Style: Equatable, Sendable {
    case none
    case standard
    case abbreviated
  }
}

