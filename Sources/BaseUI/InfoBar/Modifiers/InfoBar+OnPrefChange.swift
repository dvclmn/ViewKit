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
  @State private var sections: [GroupedSection] = []
//  @State private var items: [InfoBarItem] = []

  let isEnabled: Bool
  public func body(content: Content) -> some View {

    content
      .paddingCompatible(.bottom, isEnabled ? Styles.infoBarHeight : nil)
      .onPreferenceChange(InfoBarKey.self) { newItems in
        debouncer.executeAsync {
          await handlePreferenceChange(newItems)
        }

      }
      .overlay(alignment: .bottom) {
        if isEnabled {
          InfoBarView(sections: sections)
        }
      }

  }
}

extension InfoBarItemsModifier {
  
  private func handlePreferenceChange(_ newItems: [InfoBarItem]) {

    guard isEnabled else { return }
    /// Now this only runs when `newItems` actually changes
    let grouped = Dictionary(grouping: newItems, by: \.sectionKey)

    /// Group and Sort once
    self.sections = grouped.map { (key, items) in
      GroupedSection(id: key, title: key.title, items: items)
    }.sorted { $0.title < $1.title }

  }
}
extension View {
  public func infoBarView(isEnabled: Bool = true) -> some View {
    self.modifier(InfoBarItemsModifier(isEnabled: isEnabled))
  }
}

/// Small helper struct for  processed InfoBar data
public struct GroupedSection: Identifiable {
  public let id: InfoBarSectionID
  let title: String
  let items: [InfoBarItem]
}
