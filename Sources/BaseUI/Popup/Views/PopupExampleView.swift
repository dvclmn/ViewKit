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

    VStack {
      Text("HFuw")
      PopupView(
        .example01,
        isCompact: true,
        hasCloseButton: true
      )
      
      PopupView(
        .example01,
        isCompact: false,
        hasCloseButton: false
      )
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
