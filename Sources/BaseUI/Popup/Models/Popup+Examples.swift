//
//  Popup+Examples.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import SwiftUI

extension PopupMessage {
  public static func make(
    _ title: String,
    loading: PopupLoading = .none,
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: QuickLabel(title),
      loading: loading,
      actions: actions
    )
  }

  public static func make(
    _ title: String,
    icon: IconLiteral,
    message: String? = nil,
    loading: PopupLoading = .none,
    actions: PopupAction...
  ) -> Self {
    PopupMessage(
      label: QuickLabel(title, icon: icon),
      loading: loading,
      actions: actions
    )
  }

  //  public static func make<Content: View>(
  //    _ title: String,
  //    icon: IconLiteral,
  //    loading: PopupLoading = .none,
  //    dismissal: PopupDismissBehaviour = .manual,
  //    @ViewBuilder actions: () -> Content
  ////    actions: PopupAction...
  //  ) -> Self {
  ////    PopupMessage(
  ////      label: QuickLabel(title, icon: icon),
  ////      loading: loading,
  ////      actions: actions
  ////    )
  //  }

  static let example01 = Self.make(
    "I am loading",
    icon: .preset(.controller),
    //    icon: .preset(.getRandom),
    message: "Here is a random icon, and a loading indicator.",
    loading: .indeterminate,
    //    role: .neutral,
    //    dismissal: .automatic(2)
  )

  static let example02 = Self.make(
    "Library Exported Successfully",
    icon: "checkmark.circle.fill",
    message: "Here is some example text",
    loading: .none,
    //    role: .error,
    actions: PopupAction(
      title: "Test button action"
    ) {
      print("Hello it's an aciton")
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
