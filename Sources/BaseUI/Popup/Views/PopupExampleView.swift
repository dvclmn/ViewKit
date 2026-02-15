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
      PopupView(.example01)
        .environment(\.isCompactMode, true)

      PopupView(.example01)
        .environment(\.isCompactMode, false)

      PopupView(
        PopupMessage(
          "Another Popup",
          icon: .emoji("⏰"),
          message: nil,
          isLoading: true,
          role: .warning,
          dismissal: .automatic(1, showsIndicator: true),
          action: nil
        )
      )
      .environment(\.isCompactMode, false)
    }
    .padding(30)
    .background(.black.secondary)
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
