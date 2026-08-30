//
//  InfoBarModifier.swift
//  ViewKit
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore

@MainActor
struct InfoBarModifier<LeadingContent: View, TrailingContent: View>: ViewModifier {
  @Environment(\.infoBarStore) private var inheritedStore
  @State private var ownedStore = InfoBarStore()

  let isEnabled: Bool
  let hasAdditionalContent: Bool
  let leadingContent: LeadingContent
  let trailingContent: TrailingContent

  init(
    isEnabled: Bool,
    @ViewBuilder leadingContent: () -> LeadingContent,
    @ViewBuilder trailingContent: () -> TrailingContent,
  ) {
    self.isEnabled = isEnabled
    self.hasAdditionalContent = true
    self.leadingContent = leadingContent()
    self.trailingContent = trailingContent()
  }

  func body(content: Content) -> some View {
    let activeStore = activeStore

    content
      .environment(\.infoBarStore, activeStore)
      .environment(\.isInfoBarPresent, shouldPresent || inheritedStore != nil)
      .safeAreaBarCompatible(edge: .bottom, alignment: .leading, spacing: 0) {
        if shouldPresent {
          InfoBarView(
            store: ownedStore,
            hasAdditionalContent: hasAdditionalContent,
            leadingContent: leadingContent,
            trailingContent: trailingContent,
          )
        }

      }
      .onAppear {
        #if DEBUG
        if isEnabled, inheritedStore != nil {
          print(
            "⚠️ Warning: Duplicate InfoBarModifier detected at this view level. Child InfoBar is being ignored."
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

extension InfoBarModifier {
  init(isEnabled: Bool) where LeadingContent == EmptyView, TrailingContent == EmptyView {
    self.isEnabled = isEnabled
    self.hasAdditionalContent = false
    self.leadingContent = EmptyView()
    self.trailingContent = EmptyView()
  }

  init(
    isEnabled: Bool,
    @ViewBuilder leadingContent: () -> LeadingContent,
  ) where TrailingContent == EmptyView {
    self.isEnabled = isEnabled
    self.hasAdditionalContent = true
    self.leadingContent = leadingContent()
    self.trailingContent = EmptyView()
  }

  init(
    isEnabled: Bool,
    @ViewBuilder trailingContent: () -> TrailingContent,
  ) where LeadingContent == EmptyView {
    self.isEnabled = isEnabled
    self.hasAdditionalContent = true
    self.leadingContent = EmptyView()
    self.trailingContent = trailingContent()
  }
}
