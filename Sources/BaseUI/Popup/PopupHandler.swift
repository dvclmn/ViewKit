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

  public init(message: PopupMessage? = nil) {
    self.popupMessage = message
  }
}

extension Popup {

  package func showAndHidePopup(popupMessage: PopupMessage) async {
    //    print("Showing a popup at \(Date.debug): \(popupMessage)")
    popupTask?.cancel()
    popupTask = Task { @MainActor in
      await displayPopup(popupMessage: popupMessage)

      /// If no auto-dismiss duration, then we're done, and can exit
      switch popupMessage.dismissal {
        case .automatic(let duration, _):
          do {
            //            print(
            //              "Starting count-down for auto-dismissed Popup. Auto-dismiss Duration is \(duration.displayString)"
            //            )
            try await Task.sleep(for: .seconds(duration))

            await hidePopup()

          } catch {

          }

        case .manual:
          self.popupTask?.cancel()
          self.popupTask = nil
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
