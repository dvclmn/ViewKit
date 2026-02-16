//
//  PopupViewModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/5/2025.
//

import BasePrimitives
import SwiftUI

public struct PopupSetupModifier: ViewModifier {
  @State private var popup = Popup()

  public func body(content: Content) -> some View {
    content
      .environment(\.popup, popup)
  }
}

public struct PopupViewModifier: ViewModifier {
  let debugPopup: PopupDebug
  let alignment: Alignment
  let isCompact: Bool
  let hasCloseButton: Bool

  public func body(content: Content) -> some View {
    content
      .popupViewOnly(
        debugPopup: debugPopup,
        alignment: alignment,
        isCompact: isCompact,
        hasCloseButton: hasCloseButton
      )
      .setUpPopup()
  }
}

/// A version where the state is already initialised somewhere else,
/// and the Popup view is needed elsewhere in the app, such as the Settings window
public struct PopupViewExtenderModifier: ViewModifier {
  @Environment(\.popup) private var popup

  let debugPopup: PopupDebug
  let alignment: Alignment
  let isCompact: Bool
  let hasCloseButton: Bool

  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        /// This allows providing a warning that there's no popup set in the Env
        if let popup {
          if let message = popup.popupMessage {
            PopupView(message: message)
              .environment(\.isCompactMode, isCompact)
              .environment(\.hasCloseButton, hasCloseButton)
          }

        } else {
          StateView("No popup set in the Environment", icon: .emoji("🚨"))
            .quickRoundedBackground(rounding: Styles.sizeMedium)
            .padding()
        }
      }

  }
}

extension View {

  /// Initialises Popup handler and injects into Environment
  /// Does not display a popup view
  public func setUpPopup() -> some View {
    self.modifier(PopupSetupModifier())
  }

  /// Initialises Popup handler and displays Popup view
  public func popup(
    debugPopup: PopupDebug = .none,
    alignment: Alignment = .top,
    isCompact: Bool = false,
    hasCloseButton: Bool = false
  ) -> some View {
    self.modifier(
      PopupViewModifier(
        debugPopup: debugPopup,
        alignment: alignment,
        isCompact: isCompact,
        hasCloseButton: hasCloseButton
      )
    )
  }

  /// Displays Popup View only, does not initialise handler.
  /// This modifier assume the Popup is already in the Environment,
  /// and will display a warning View if it's not.
  public func popupViewOnly(
    debugPopup: PopupDebug = .none,
    alignment: Alignment = .top,
    isCompact: Bool = false,
    hasCloseButton: Bool = false
  ) -> some View {
    self.modifier(
      PopupViewExtenderModifier(
        debugPopup: debugPopup,
        alignment: alignment,
        isCompact: isCompact,
        hasCloseButton: hasCloseButton
      )
    )
  }
}
