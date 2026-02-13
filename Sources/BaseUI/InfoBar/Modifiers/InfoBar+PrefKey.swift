//
//  Model+InfoBar.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import SwiftUI

// MARK: - PreferenceKey and Reduce Function

public struct InfoBarKey: PreferenceKey {
  public static let defaultValue: [InfoBarItem] = []

  public static func reduce(value: inout [InfoBarItem], nextValue: () -> [InfoBarItem]) {

    let next = nextValue()
    if next.isEmpty { return }

    /// Efficiently filter out duplicates using the Hashable conformance
    let existingIDs = Set(value.map(\.id))
    value.append(contentsOf: next.filter { !existingIDs.contains($0.id) })

  }
}

// MARK: - Modifier for Child Views, to add to InfoBar
extension View {
  /// For when constructing multiple info bar items from e.g.
  /// an enum conforming to `InfoBarSection`
  public func addInfoBarItems<T>(
    _ items: T.Type,
    source: T.Source,
    format: DisplayFormat = .default
  ) -> some View
  where T: InfoBarItemDescriptor & CaseIterable {
    self.preference(
      key: InfoBarKey.self,
      value: items.items(from: source, format: format)
    )
  }

  public func addInfoBarItems<K: InfoBarSectionKey>(
    _ items: String...,
    key: K.Type = DebugSectionKey.self,
    format: DisplayFormat = .default
  ) -> some View {
    self.preference(
      key: InfoBarKey.self,
      value: items.map { text in
        InfoBarItem(
          section: key,
          label: QuickLabel(stringLiteral: ""),
          content: text
        )
      }
    )
  }

  public func addInfoBarItems<K: InfoBarSectionKey>(
    _ items: (String, String)...,
    key: K.Type = DebugSectionKey.self,
    format: DisplayFormat = .default
  ) -> some View {
    self.preference(
      key: InfoBarKey.self,
      value: items.map { text in
        InfoBarItem(
          section: key,
          label: QuickLabel(stringLiteral: text.0),
          content: text.1
        )
      }
    )
  }
}
