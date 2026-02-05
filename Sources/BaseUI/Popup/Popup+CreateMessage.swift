//
//  Popup+Message.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import CoreTools
import Foundation

extension Popup {

  public func showPopup(
    _ title: String,
    icon: IconLiteral? = nil,
    message: String? = nil,
    isLoading: Bool = false,
    action: PopupAction? = nil
  ) {

    let popupMessage = PopupMessage(
      title,
      icon: icon,
      message: message,
      isLoading: isLoading,
      action: action
    )
    Task { @MainActor in
      await showAndHidePopup(popupMessage: popupMessage)
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
      let title = error.errorDescription ?? "An unknown error occurred"
      showPopup(title, message: error.recoverySuggestion)
    }
  }
}
