//
//  Model+PatternStyle.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import CasePaths
import Foundation

@CasePathable
@dynamicMemberLookup
public enum PatternStyle: String, CaseIterable, Identifiable, Codable, Sendable {
  case checkerboard
  case chevron
  case stitches
  case waves
  case stripes

  public var id: String {
    self.name
  }

  public var name: String {
    switch self {
      default: rawValue.capitalized
    }
  }
}
