//
//  Popup+Examples.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

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
    action: PopupAction(
      title: "Test button action",
      action: {
        print("Hello it's an aciton")
      })
  )
}
