//
//  Popup+Examples.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools

extension PopupMessage {
  static let example01 = PopupMessage(
    "I am loading",
    icon: .preset(.controller),
//    icon: .preset(.getRandom),
    message: "Here is a random icon, and a loading indicator.",
    isLoading: true,
    role: .neutral,
    dismissal: .automatic(2)
  )

  static let example02 = PopupMessage(
    "Library Exported Successfully",
    icon: "checkmark.circle.fill",
    message: "Here is some example text",
    isLoading: true,
    role: .error,
    action: PopupAction(
      title: "Test button action",
      action: {
        print("Hello it's an aciton")
      }
    )
  )
}

extension PopupMessage {
  public static func success(
    _ title: String,
    message: String? = nil,
    action: PopupAction? = nil
  ) -> PopupMessage {
    PopupMessage(
      title,
      icon: .preset(.tick),
      message: message,
      isLoading: false,
      role: .neutral,
      dismissal: .automatic(2),
      action: action
    )
  }

  public static func error(
    _ title: String,
    message: String? = nil,
    action: PopupAction? = nil
  ) -> PopupMessage {
    PopupMessage(
      title,
      icon: .preset(.warning),
      message: message,
      isLoading: false,
      role: .error,
      dismissal: .manual,
      action: action
    )
  }
}
