//
//  Models.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import CoreTools
import SampleBuilder
import SwiftUI

public struct PopupMessage: Sendable, Identifiable {
  public let id: UUID

  var label: QuickLabel
  let message: String?
  let loading: PopupLoadingIndicator
  var dismissal: PopupDismissBehaviour
  var actions: [PopupAction]

  public init(
    id: UUID = UUID(),
    label: QuickLabel,
    message: String? = nil,
    loading: PopupLoadingIndicator = .none,
    dismissal: PopupDismissBehaviour = .manual,
    actions: [PopupAction] = []
  ) {
    self.id = id
    self.label = label
    self.message = message
    self.loading = loading
    self.dismissal = dismissal
    self.actions = actions
  }
}

// MARK: - Builders
extension PopupMessage {

  public static func make(
    _ title: String,
    loading: PopupLoadingIndicator = .none,
    dismissal: PopupDismissBehaviour = .automatic(),
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: QuickLabel(title),
      loading: loading,
      dismissal: dismissal,
      actions: actions
    )
  }

  public static func make(
    _ title: String,
    icon: IconLiteral,
    message: String? = nil,
    loading: PopupLoadingIndicator = .none,
    dismissal: PopupDismissBehaviour = .automatic(),
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: QuickLabel(title, icon: icon),
      message: message,
      loading: loading,
      dismissal: dismissal,
      actions: actions
    )
  }
}

extension PopupMessage {

  public var title: String { label.text }
  public var icon: IconLiteral? { label.icon }
  public var iconString: String? { label.icon?.toString }
}

extension PopupMessage: CustomStringConvertible {
  public var description: String {
    DisplayString {
      Indented("Popup Message") {
        Labeled("Label", value: label)
        Labeled("Message", value: message)
        Labeled("Loading?", value: loading)
        Labeled("Dismiss Behaviour", value: dismissal)
        Labeled("Action", value: actions)
      }
    }.text
  }
}

extension PopupMessage: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {
    self.init(label: QuickLabel(value))
  }
}

public enum PopupLocation: String, Sendable, Equatable {
  case main
  case systemSettings

  public var id: String { self.rawValue }

}
