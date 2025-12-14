//
//  PopupViewModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/5/2025.
//

import SharedHelpers
import SwiftUI

@available(macOS 14.0, *)
public struct PopupViewModifier: ViewModifier {
  @Environment(\.popup) private var popup

  let debugPopup: PopupDebug
  let alignment: Alignment
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {

        PopupView(debugPopup.message ?? popup?.popupMessage)
          .padding(Styles.sizeRegular)
      }
  }
}

@available(macOS 14.0, *)
extension View {
  public func popupView(
    debugPopup: PopupDebug,
    //    debugPopup: PopupMessage? = nil,
    alignment: Alignment = .top
  ) -> some View {
    self.modifier(
      PopupViewModifier(
        debugPopup: debugPopup,
        alignment: alignment
      ))
  }
}
