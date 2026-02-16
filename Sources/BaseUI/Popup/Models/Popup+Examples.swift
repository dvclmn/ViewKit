//
//  Popup+Examples.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import SwiftUI

extension PopupMessage {

  public static let example01 = Self.make(
    "I am loading",
    icon: .preset(.controller),
    //    icon: .preset(.getRandom),
    message: "Here is a random icon, and a loading indicator.",
    loading: .indeterminate,
    //    role: .neutral,
    //    dismissal: .automatic(2)
  )

  public static let example02 = Self.make(
    "Library Exported Successfully",
    icon: "checkmark.circle.fill",
    message: "Here is some example text",
    loading: .none,
    //    role: .error,
    actions: PopupAction(
      title: "Test button action"
    ) {
      print("Hello it's an action")
    }
  )
}

extension PopupMessage {
  public static func success(
    _ title: String,
    message: String? = nil,
    actions: PopupAction...
  ) -> PopupMessage {
    PopupMessage(
      label: QuickLabel(title, icon: .preset(.tick)),
      message: message,
      loading: .none,
      dismissal: .automatic(2),
      actions: actions
    )
  }

  public static func error(
    _ title: String,
    message: String? = nil,
    action: PopupAction...
  ) -> PopupMessage {
    PopupMessage(
      label: QuickLabel(title, icon: .preset(.warning)),
      message: message,
      loading: .none,
      actions: action
    )
  }
}
