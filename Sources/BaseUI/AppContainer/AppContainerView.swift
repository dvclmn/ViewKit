//
//  AppContainerView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/6/2025.
//

import SwiftUI

@available(macOS 14.0, *)
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
      #if canImport(AppKit)
    .readModifierKeys()
      #endif
  }
}
