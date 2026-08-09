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

  public private(set) var popupMessage: PopupMessage?
  private var dismissalTask: Task<Void, Never>?

  public init(message: PopupMessage? = nil) {
    self.popupMessage = message
  }

  isolated deinit {
    dismissalTask?.cancel()
  }
}

extension Popup {

  package func present(_ message: PopupMessage) {
    dismissalTask?.cancel()
    dismissalTask = nil
    popupMessage = message

    AccessibilityNotification.Announcement(message.accessibilityAnnouncement).post()

    guard let duration = message.dismissal.autoDismissDuration else { return }

    dismissalTask = Task { @MainActor [weak self] in
      do {
        try await Task.sleep(for: .seconds(duration))
      } catch is CancellationError {
        return
      } catch {
        return
      }

      self?.dismiss(messageID: message.id)
    }
  }

  public func dismiss() {
    dismiss(messageID: popupMessage?.id)
  }

  private func dismiss(messageID: UUID?) {
    guard popupMessage?.id == messageID else { return }

    dismissalTask?.cancel()
    dismissalTask = nil
    popupMessage = nil
  }
}
