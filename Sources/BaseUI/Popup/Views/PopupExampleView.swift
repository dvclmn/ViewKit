//
//  PopupExampleView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 10/6/2025.
//

import SwiftUI

import SharedHelpers

@available(macOS 14.0, *)
public struct PopupExampleView: View {
  @Environment(\.popup) private var popup
  public var body: some View {
    
    Button {
      popup?.showPopup(.example02)
    } label: {
      Label("Test Popup", systemImage: Icons.text.icon)
    }
    .padding(40)
    .frame(width: 600, height: 700)
    .background(.black.opacity(0.6))
    .popupView(debugPopup: .none)
//      .onAppear {
//        popup.showPopup(examplePopup)
//      }
    
  }
}

//extension PopupExampleView {
//  
//}
#if DEBUG
@available(macOS 14.0, *)
#Preview {
  PopupExampleView()
    .environment(Popup())
}
#endif

