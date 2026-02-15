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

    Form {
      Section("Compact, Has Close Button") {
        Group {
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
      }
      
    }
    .formStyle(.grouped)
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

//extension PopupExampleView {
//
//}
#if DEBUG
#Preview {
  @Previewable @State var popup = Popup()
  PopupExampleView()
    .environment(popup)
}
#endif
