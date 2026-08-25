//
//  InfoBar+OnPrefChange.swift
//  ViewKit
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore

@MainActor
struct InfoBarItemsModifier: ViewModifier {
  @Environment(\.infoBarStore) private var inheritedStore
  @State private var ownedStore = InfoBarStore()

  let isEnabled: Bool

  func body(content: Content) -> some View {
    let activeStore = activeStore

    content
      .environment(\.infoBarStore, activeStore)
      .environment(\.isInfoBarPresent, shouldPresent || inheritedStore != nil)
      .safeAreaInset(edge: .bottom, spacing: 0) {
        if shouldPresent {
          RegisteredInfoBarView(store: ownedStore)
        }
      }
      .onAppear {
        #if DEBUG
        if isEnabled, inheritedStore != nil {
          print(
            "⚠️ Warning: Duplicate InfoBarModifier detected at this view level. Child InfoBar is being suppressed."
          )
        }
        #endif
      }
  }

  private var activeStore: InfoBarStore? {
    if let inheritedStore {
      inheritedStore
    } else if isEnabled {
      ownedStore
    } else {
      nil
    }
  }

  private var shouldPresent: Bool {
    isEnabled && inheritedStore == nil
  }
}
