//
//  PopupViewModifier.swift
//  BaseComponents
//
//  Created by Dave Coleman on 28/5/2025.
//

import SharedHelpers
import SwiftUI

public struct PopupViewModifier: ViewModifier {
  @Environment(\.popup) private var popup
  let debugPopup: PopupMessage?
  let alignment: Alignment
  public func body(content: Content) -> some View {
    content
      .overlay(alignment: alignment) {
        //        if let debugPopup = debugPopup {
        PopupView(debugPopup ?? popup?.popupMessage)
          .padding(Styles.sizeRegular)

        //        } else if let activeMessage = popup.popupMessage {
        //          PopupView(activeMessage)
        //            .padding(Styles.sizeRegular)
        //        }
      }

  }
}
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

public enum PopupDebug {
  case example
  case custom(PopupMessage)
  case none
}
