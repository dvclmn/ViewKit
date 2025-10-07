//
//  Models.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import BaseHelpers
import SwiftUI
import SharedHelpers

public struct PopupAction {
  let title: String
  let action: () -> Void
  
  public init(title: String, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
}

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

extension PopupMessage {
  static let example01 = PopupMessage(
    "I am loading",
    icon: Icons.getRandomIcon,
    message: "Here is a random icon, and a loading indicator.",
    isLoading: true,
    role: .normal,
    dismissal: .automatic(2)
  )

  static let example02 = PopupMessage(
    "Library Exported Successfully",
    icon: "checkmark.circle.fill",
    message: "Here is some example text",
    isLoading: true,
    role: .error,
    action: PopupAction(title: "Test button action", action: {
      print("Hello it's an aciton")
    })
  )

}

public enum PopupRole {
  case normal
  case warning
  case error
  
  public var colour: Color {
    switch self {
      case .normal:
        return .gray
      case .warning:
        return .yellow
      case .error:
        return .red
    }
  }
}

//public enum ErrorSeverity: Equatable {
//  case error
//  case warning
//
//}

public enum PopupLocation: String, Sendable, Equatable {
  case main
  case systemSettings

  public var id: String { self.rawValue }

}

public enum PopupDismissBehaviour: Equatable {
  case automatic(TimeInterval, showsIndicator: Bool = false)
  case manual
  
  public var autoDismissDuration: TimeInterval? {
    if case .automatic(let interval, _) = self {
      return interval
    } else {
      return nil
    }
  }
  public var shouldShowDismissTimingIndicator: Bool {
    if case .automatic(_, let showsIndicator) = self {
      return showsIndicator
    } else {
      return false
    }
  }
}
