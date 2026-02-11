//
//  ToggleKind.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/2/2026.
//

import Foundation

public enum ToggleKind: String, Sendable {
  case expanded
  case enabled
}

extension ToggleKind {
  /// Suffix used for the camelCase style builder (e.g. "Enabled", "Expanded")
  package var camelSuffix: String {
    switch self {
      case .enabled: return "Enabled"
      case .expanded: return "Expanded"
    }
  }
}
