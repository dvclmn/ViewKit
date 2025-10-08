//
//  Model+InfoBar.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//


import SharedHelpers
import SwiftUI

// MARK: - PreferenceKey and Reduce Function
public typealias InfoBarItems = [InfoBarItem]

public struct InfoBarKey: PreferenceKey {

  public static let defaultValue: InfoBarItems = []

  public static func reduce(value: inout InfoBarItems, nextValue: () -> InfoBarItems) {
    let new = nextValue()
    guard !new.isEmpty else { return }
    for item in new where !value.contains(where: { $0.id == item.id }) {
      value.append(item)
    }
  }
}

// MARK: - Modifier for Child Views, to add to InfoBar
extension View {
  public func addInfoBarItems(_ items: InfoBarItems) -> some View {
    return self.preference(key: InfoBarKey.self, value: items)
  }
}

// MARK: - Modifier for Root View, to recieve data and Display bar
public struct InfoBarItemsModifier: ViewModifier {

  @State private var items: InfoBarItems = []

  public func body(content: Content) -> some View {
    content
      .safeAreaPadding(.bottom, Styles.infoBarHeight)
      .onPreferenceChange(InfoBarKey.self) { newItems in
        updateIfChanged(&items, to: newItems)
        //        updateIfChanged(newItems, into: &items)
      }
      .overlay(alignment: .bottom) {
        InfoBar(items: items)
      }

  }
}
extension View {
  public func infoBarView() -> some View {
    self.modifier(InfoBarItemsModifier())
  }
}
