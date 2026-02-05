//
//  Models.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import CoreTools
import SwiftUI

public struct PopupMessage: Sendable, Identifiable {
  public let id: UUID

  public let label: QuickLabel
  public let message: String?
  public let isLoading: Bool
  public let dismissal: PopupDismissBehaviour
  public let action: PopupAction?

  public init(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
    isLoading: Bool = false,
    role: ActionRole = .neutral,
    dismissal: PopupDismissBehaviour = .automatic(3.5),
    action: PopupAction? = nil
  ) {
    self.id = UUID()
    self.label = QuickLabel(title, icon: icon, role: role)
    self.message = message
    self.isLoading = isLoading
    self.dismissal = dismissal
    self.action = action
  }
}

// MARK: - Convenience inits
extension PopupMessage {
//  public init(
//    _ title: String,
//    icon: IconLiteral? = nil,
//    message: String? = nil,
//    isLoading: Bool = false,
//    role: ActionRole = .neutral,
//    dismissal: PopupDismissBehaviour = .automatic(3.5),
//    action: PopupAction? = nil
//  ) {
//    self.id = UUID()
//    self.label = QuickLabel(title, icon: icon, role: role)
//    self.message = message
//    self.isLoading = isLoading
//    self.dismissal = dismissal
//    self.action = action
//  }
}

extension PopupMessage: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(value)
  }
}

public enum PopupLocation: String, Sendable, Equatable {
  case main
  case systemSettings

  public var id: String { self.rawValue }

}
