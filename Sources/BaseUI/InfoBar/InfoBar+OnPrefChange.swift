//
//  InfoBar+OnPrefChange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI

public struct InfoBarItemsModifier: ViewModifier {

  @State private var debouncer = AsyncDebouncer(interval: 0.2)

  @State private var items: [InfoBarItem] = []

  let isEnabled: Bool
  public func body(content: Content) -> some View {

    content
      .paddingCompatible(.bottom, isEnabled ? Styles.infoBarHeight : nil)
      .onPreferenceChange(InfoBarKey.self) { newItems in
        Task {
          debouncer.execute { @MainActor in
            guard isEnabled else { return }
            updateIfChanged(&items, to: newItems)
          }
        }
      }
      .overlay(alignment: .bottom) {
        if isEnabled {
          InfoBar(items: items)
        }
      }

  }
}
extension View {
  public func infoBarView(isEnabled: Bool = true) -> some View {
    self.modifier(InfoBarItemsModifier(isEnabled: isEnabled))
  }
}
