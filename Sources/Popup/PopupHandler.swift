//
//  Popup.swift
//  Eucalypt
//
//  Created by Dave Coleman on 24/3/2024.
//

import SwiftUI

@MainActor
@Observable
public final class Popup: Sendable {

  var popupMessage: PopupMessage? = nil
  private var popupTask: Task<Void, Never>? = nil

  public init(
    message: PopupMessage? = nil
  ) {
    self.popupMessage = message
  }
}

extension Popup {

  public func showPopup(
    _ title: String,
    icon: String? = nil,
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

  public func showPopup(_ popupMessage: PopupMessage) {
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

  private func showAndHidePopup(popupMessage: PopupMessage) async {
    popupTask?.cancel()
    //    print("Popup triggered: \(popupMessage.title)")

    popupTask = Task { @MainActor in
      await displayPopup(popupMessage: popupMessage)

      //      do {

      if let duration = popupMessage.dismissal.autoDismissDuration {
        do {
          try await Task.sleep(for: .seconds(duration))
          await hidePopup()
          
        } catch {
          
        }
      }

    }
  }  // END show hide popup

  @MainActor
  private func displayPopup(popupMessage: PopupMessage) async {
    Task { @MainActor in
      withAnimation(.easeOut(duration: 0.1)) {
        self.popupMessage = popupMessage
      }
    }
  }

  @MainActor
  private func hidePopup() async {
    Task { @MainActor in
      withAnimation(.easeInOut(duration: 0.6)) {
        self.popupMessage = nil
        self.popupTask?.cancel()
        self.popupTask = nil
      }
    }
  }
}
