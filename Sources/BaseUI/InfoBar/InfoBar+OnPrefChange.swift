//
//  InfoBar+OnPrefChange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import BasePrimitives
import SwiftUI

public struct InfoBarItemsModifier: ViewModifier {
  //  @Environment(\.isEnabled) private var isEnabled
  @State private var items: [InfoBarItem] = []

  let isEnabled: Bool
  public func body(content: Content) -> some View {

    content
      .paddingCompatible(.bottom, isEnabled ? Styles.infoBarHeight : nil)
      .onPreferenceChange(InfoBarKey.self) { newItems in
        guard isEnabled else { return }
        updateIfChanged(&items, to: newItems)

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
