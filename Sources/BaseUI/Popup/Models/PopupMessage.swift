//
//  Models.swift
//  Components
//
//  Created by Dave Coleman on 14/2/2025.
//

import CoreTools
import ViewTools
@_spi(Internal) import StringTools
import SwiftUI

public struct PopupMessage: Sendable, Identifiable {
  public let id: UUID

  public var label: LabelDescriptor
  public let message: String?
  public let loading: PopupLoadingIndicator
  public var dismissal: PopupDismissBehaviour
  public var actions: [PopupAction]

  public init(
    id: UUID = UUID(),
    label: LabelDescriptor,
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
  public mutating func add(actions: PopupAction...) {
    //    var copy = self
    self.actions.append(contentsOf: actions)
  }

  public static func make(
    _ title: String,
    loading: PopupLoadingIndicator = .none,
    dismissal: PopupDismissBehaviour? = nil,
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: LabelDescriptor(title),
      loading: loading,
      dismissal: dismissal ?? defaultDismissal(loading: loading, actions: actions),
      actions: actions
    )
  }

  public static func make(
    _ title: String,
    icon: IconLiteral,
    message: String? = nil,
    loading: PopupLoadingIndicator = .none,
    dismissal: PopupDismissBehaviour? = nil,
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: LabelDescriptor(title, icon: icon),
      message: message,
      loading: loading,
      dismissal: dismissal ?? defaultDismissal(loading: loading, actions: actions),
      actions: actions
    )
  }

  private static func defaultDismissal(
    loading: PopupLoadingIndicator,
    actions: [PopupAction]
  ) -> PopupDismissBehaviour {
    loading == .none && actions.isEmpty ? .automatic() : .manual
  }
}

extension PopupMessage {

  public var title: String { label.text }
  public var icon: IconLiteral? { label.icon }
  public var iconString: String? { label.icon?.stringValue }

  var accessibilityAnnouncement: String {
    [title, message]
      .compactMap { $0 }
      .joined(separator: ". ")
  }
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
    self.init(label: LabelDescriptor(value))
  }
}

public enum PopupLocation: String, Sendable, Equatable {
  case main
  case systemSettings

  public var id: String { self.rawValue }

}
