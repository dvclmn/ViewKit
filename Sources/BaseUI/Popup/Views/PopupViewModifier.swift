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

  public func body(content: Content) -> some View {
    content
      .environment(\.popup, popup)
      .popupViewOnly(debugPopup: debugPopup, alignment: alignment)
//      .overlay(alignment: alignment) {
//        PopupView(
//          debugPopup.message ?? popup.popupMessage
//        )
//        .padding(Styles.sizeRegular)
//      }
  }
}

/// A version where the state is already initialised somewhere else,
/// and the Popup view is needed elsewhere in the app, such as the Settings window
public struct PopupViewExtenderModifier: ViewModifier {
  @Environment(\.popup) private var popup

  let debugPopup: PopupDebug
  let alignment: Alignment

  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        PopupView(
          debugPopup.message ?? popup?.popupMessage
        )
        .padding(Styles.sizeRegular)
      }
  }
}

extension View {
  public func popup(
    debugPopup: PopupDebug = .none,
    alignment: Alignment = .top
  ) -> some View {
    self.modifier(
      PopupViewModifier(
        debugPopup: debugPopup,
        alignment: alignment
      )
    )
  }
  
  public func popupViewOnly(
    debugPopup: PopupDebug = .none,
    alignment: Alignment = .top
  ) -> some View {
    self.modifier(
      PopupViewExtenderModifier(
        debugPopup: debugPopup,
        alignment: alignment
      )
    )
  }
}
