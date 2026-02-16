//
//  PopupExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/6/2025.
//

import BasePrimitives
import SwiftUI

public struct PopupExampleView: View {
  @Environment(\.popup) private var popup

  public var body: some View {

    ScrollView {
      VStack(alignment: .leading, spacing: Styles.sizeLarge) {
//        PopupView(
//          PopupMessage(
//            "Compact, *No* Glass",
//            icon: .preset(.message),
//            message: "Here is a random icon, and a loading indicator.",
//            isLoading: true,
//            role: .neutral,
//            dismissal: .automatic(2)
//          )
//        )
//        .environment(\.isCompactMode, true)
//        .environment(\.hasGlassEffect, false)
//
//        PopupView(
//          PopupMessage(
//            "Compact, Glass Effect",
//            icon: .preset(.message),
//            message: "Here is a random icon, and a loading indicator.",
//            isLoading: true,
//            role: .neutral,
//            dismissal: .automatic(2)
//          )
//        )
//        .environment(\.isCompactMode, true)
//        .environment(\.hasGlassEffect, true)

//        PopupView(
//          PopupMessage(
//            "No Glass, Regular Size",
//            icon: .preset(.controller),
//            //    icon: .preset(.getRandom),
//            message: "Here is a random icon, and a loading indicator.",
//            isLoading: true,
//            role: .neutral,
//            dismissal: .automatic(2)
//          )
//        )
//        .environment(\.hasGlassEffect, false)
        PopupView(
          message: PopupMessage(
            "Glass Effect, Regular Size",
            icon: .preset(.controller),
            //    icon: .preset(.getRandom),
            message: "This View is a little larger, so the Glass Effect is slightly more opaque.",
            isLoading: true,
            role: .neutral,
            dismissal: .automatic(2)
          ),
          alignment: .topTrailing
        )
        .environment(\.hasGlassEffect, true)

        PopupView(
          message: PopupMessage(
            "Compact Popup",
            icon: .emoji("⏰"),
            message: nil,
            isLoading: true,
            role: .warning,
            dismissal: .automatic(1, showsIndicator: true),
            action: nil
          ),
          alignment: .topTrailing
        )
        .environment(\.isCompactMode, true)
        .environment(\.hasGlassEffect, true)

        PopupView(
          message: PopupMessage(
            "Not Compact",
            icon: .emoji("⏰"),
            message: "This Popup has a indicator showing how long until it disappears.",
            isLoading: true,
            role: .warning,
            dismissal: .automatic(1, showsIndicator: true),
            action: nil
          ),
          alignment: .topTrailing
        )
        .environment(\.isCompactMode, false)
        .environment(\.hasGlassEffect, false)

        PopupView(
          message: PopupMessage(
            "Another Popup",
            icon: .preset(.binoculars),
            message: nil,
            isLoading: true,
            role: .warning,
            dismissal: .manual,
            action: PopupAction(title: "See More", action: {  })
          ),
          alignment: .topTrailing
        )
        .environment(\.hasCloseButton, true)
        .environment(\.hasGlassEffect, true)

      }
      .padding(30)
    }
    .halfImageDebugBackground(balance: 0.3)

    .toolbar {
      ToolbarItem {
        Button("Test Popup") {
          popup?.showPopup(.example02)
        }
      }
    }
  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  PopupExampleView()
    .popup()
}
#endif
