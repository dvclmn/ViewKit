//
//  InfoBar+OnPrefChange.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI

struct InfoBarItemsModifier: ViewModifier {
  @Environment(\.isInfoBarPresent) private var isInfoBarPresent

  @State private var sections: [InfoBarSection] = []
  @State private var debouncer: AsyncDebouncer?

  let isEnabled: Bool

  init(
    mode: DebounceMode,
    isEnabled: Bool
  ) {
    self._debouncer = mode.createDebouncer()
    self.isEnabled = isEnabled
  }

  func body(content: Content) -> some View {

    content
      .contentMargins(
        isEnabled ? .bottom : [],
        EdgeInsets(
          top: Styles.infoBarHeight,
          leading: 0,
          bottom: Styles.infoBarHeight,
          trailing: 0
        ),
        for: .automatic
      )
      .safeAreaPadding(.bottom, isEnabled ? Styles.infoBarHeight : nil)
      .onPreferenceChange(InfoBarKey.self) { newItems in
        guard shouldDisplay else { return }
        if let debouncer {
          debouncer.execute { @MainActor in
            handlePreferenceChange(newItems)
          }
        } else {
          handlePreferenceChange(newItems)
        }

      }
      .overlay(alignment: .bottom) {
        if shouldDisplay {
          InfoBarView(sections: sections)
        }
      }

      /// Tell all children that an InfoBar is now present
      .environment(\.isInfoBarPresent, isEnabled)

      .onAppear {
        #if DEBUG
        if isEnabled && isInfoBarPresent {
          print(
            "⚠️ Optimization Warning: Duplicate InfoBarModifier detected at this view level. Child InfoBar is being suppressed."
          )
        }
        #endif
      }

  }
}

extension InfoBarItemsModifier {

  private var shouldDisplay: Bool { isEnabled && !isInfoBarPresent }

  private func handlePreferenceChange(_ newItems: [InfoBarItem]) {

    /// Now this only runs when `newItems` actually changes
    let grouped = Dictionary(grouping: newItems, by: \.sectionKey)

    /// Group and Sort once
    self.sections = grouped.map { (key, items) in
      InfoBarSection(id: key, title: key.title, items: items)
    }.sorted { $0.title < $1.title }
  }
}

extension View {
  public func infoBarView(
    debounceMode: DebounceMode = .debounce(0.2),
    isEnabled: Bool = true
  ) -> some View {
    self.modifier(
      InfoBarItemsModifier(
        mode: debounceMode,
        isEnabled: isEnabled,
      )
    )
  }
}
