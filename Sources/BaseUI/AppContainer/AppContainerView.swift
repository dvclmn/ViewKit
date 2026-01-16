//
//  AppContainerView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/6/2025.
//

import SwiftUI

public struct AppContainer<Content: View>: View {

  @State private var popup = Popup()

  let content: Content

  public init(
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.content = content()
  }

  public var body: some View {
    content
      .environment(\.popup, popup)
      .popupView(debugPopup: .none)
//      .environment(\.popup, popup)
    
      #if canImport(AppKit)
    .readModifierKeys()
      #endif
  }
}
