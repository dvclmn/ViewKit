//
//  Models.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import CoreTools
import SwiftUI

@MainActor
public struct PopupMessage: Sendable, Identifiable {
  public let id: UUID
  
  public let title: String
  public let icon: String?
  public let message: String?
  public let isLoading: Bool
  public let role: PopupRole
  public let dismissal: PopupDismissBehaviour
  public let action: PopupAction?

  public init(
    _ title: String,
    icon: String? = nil,
    message: String? = nil,
    isLoading: Bool = false,
    role: PopupRole = .normal,
    dismissal: PopupDismissBehaviour = .automatic(3.5),
    action: PopupAction? = nil
  ) {
    self.id = UUID()
    self.title = title
    self.icon = icon
    self.message = message
    self.isLoading = isLoading
    self.role = role
    self.dismissal = dismissal
    self.action = action
  }
}

extension PopupMessage: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) { .init(value) }
}

public enum PopupLocation: String, Sendable, Equatable {
  case main
  case systemSettings

  public var id: String { self.rawValue }

}

public enum PopupDismissBehaviour: Equatable {
  case automatic(TimeInterval, showsIndicator: Bool = false)
  case manual

  public var autoDismissDuration: TimeInterval? {
    guard case .automatic(let interval, _) = self else {
      return nil
    }
    return interval
  }
  public var shouldShowDismissTimingIndicator: Bool {
    guard case .automatic(_, let showsIndicator) = self else {
      return false
    }
    return showsIndicator
  }
}
