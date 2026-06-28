//
//  Popup+Message.swift
//  ViewKit
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import ViewTools
import Foundation

/// For more flexible initialisers for `PopupMessage`, use static method
/// ``PopupMessage/make(_:icon:message:loading:actions:)``
extension Popup {

  public func showPopup(_ title: String) {
    Task {
      await showAndHidePopup(popupMessage: PopupMessage(label: LabelDescriptor(title)))
    }
  }

  public func showPopup(_ popupMessage: PopupMessage?) {
    guard let popupMessage else { return }
    Task { @MainActor in
      await showAndHidePopup(popupMessage: popupMessage)
    }
  }

  public func showPopup(_ error: any LocalizedError) {
    Task { @MainActor in
      let label = LabelDescriptor(
        error.errorDescription ?? "An unknown error occurred",
        icon: .preset(.warning)
      )
      showPopup(PopupMessage(label: label))
    }
  }
}
