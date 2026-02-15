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

    VStack(alignment: .leading, spacing: Styles.sizeLarge) {
      PopupView(
        PopupMessage(
          "Compact, *No* Glass",
          icon: .preset(.message),
          message: "Here is a random icon, and a loading indicator.",
          isLoading: true,
          role: .neutral,
          dismissal: .automatic(2)
        )
      )
      .environment(\.isCompactMode, true)
      .environment(\.hasGlassEffect, false)
      
      PopupView(
        PopupMessage(
          "Compact, Glass Effect",
          icon: .preset(.message),
          message: "Here is a random icon, and a loading indicator.",
          isLoading: true,
          role: .neutral,
          dismissal: .automatic(2)
        )
      )
      .environment(\.isCompactMode, true)
      .environment(\.hasGlassEffect, true)

      PopupView(
        PopupMessage(
          "No Glass, Regular Size",
          icon: .preset(.controller),
          //    icon: .preset(.getRandom),
          message: "Here is a random icon, and a loading indicator.",
          isLoading: true,
          role: .neutral,
          dismissal: .automatic(2)
        )
      )
      .environment(\.hasGlassEffect, false)
      PopupView(
        PopupMessage(
          "Glass Effect, Regular Size",
          icon: .preset(.controller),
          //    icon: .preset(.getRandom),
          message: "This View is a little larger, so the Glass Effect is slightly more opaque.",
          isLoading: true,
          role: .neutral,
          dismissal: .automatic(2)
        )
      )
      .environment(\.hasGlassEffect, true)

      PopupView(
        PopupMessage(
          "Compact Popup",
          icon: .emoji("⏰"),
          message: nil,
          isLoading: true,
          role: .warning,
          dismissal: .automatic(1, showsIndicator: true),
          action: nil
        )
      )
      .environment(\.isCompactMode, true)
      .environment(\.hasGlassEffect, true)

      PopupView(
        PopupMessage(
          "Not Compact",
          icon: .emoji("⏰"),
          message: nil,
          isLoading: true,
          role: .warning,
          dismissal: .automatic(1, showsIndicator: true),
          action: nil
        )
      )
      .environment(\.isCompactMode, false)
      .environment(\.hasGlassEffect, false)

      PopupView(
        PopupMessage(
          "Another Popup",
          icon: .preset(.binoculars),
          message: nil,
          isLoading: true,
          role: .warning,
          dismissal: .manual,
          action: nil
        )
      )
      .environment(\.hasCloseButton, true)
      .environment(\.hasGlassEffect, true)

    }
    .padding(30)
//    .background(.black.secondary)
    .halfImageDebugBackground(balance: 0.3)
    
    //    Button {
    //      popup?.showPopup(.example02)
    //    } label: {
    //      Label("Test Popup", systemImage: Icons.text.icon)
    //    }
    //    .padding(40)
    //    .frame(width: 600, height: 700)
    //    .background(.black.opacity(0.6))
    //    .popup(debugPopup: .example(.example01))
    //      .onAppear {
    //        popup.showPopup(examplePopup)
    //      }

  }
}

#if DEBUG
#Preview(traits: .size(.normal)) {
  @Previewable @State var popup = Popup()
  PopupExampleView()
    .environment(popup)
}
#endif
