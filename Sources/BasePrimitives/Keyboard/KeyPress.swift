//
//  KeyPress.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/9/2025.
//

import SwiftUI

/// Extends standard SwiftUI type `KeyPress` (not a custom type)
extension KeyPress {
  public var displayString: String {
    return """

      Key Press:
      ----------

      Phase: \(phase.name)
      Characters: \(self.characters)

      """
  }
}

extension KeyPress.Phases {
  public var name: String {
    switch self {
      case .down: "Down"
      case .repeat: "Repeat"
      case .up: "Up"
      case .all: "All"
      default: "Unknown"
    }
  }
}
