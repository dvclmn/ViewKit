//
//  PopupViewModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/5/2025.
//

import BasePrimitives
import SwiftUI

public struct PopupViewModifier: ViewModifier {

  @State private var popup = Popup()

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
      .environment(\.popup, popup)
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
        PopupView(
          debugPopup.message ?? popup?.popupMessage,
//          isCompact: isCompact,
//          hasCloseButton: hasCloseButton
        )
        .padding(Styles.sizeRegular)
        .environment(\.isCompactMode, isCompact)
        .environment(\.hasCloseButton, hasCloseButton)
      }
  }
}

extension View {
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

  /// View only means no State is set up in this View modifier.
  /// It just passes the Popup View, and assumes the Popup
  /// is already in the Environment
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
