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
    let new = nextValue()
    guard !new.isEmpty else { return }
    for item in new where !value.contains(where: { $0.id == item.id }) {
      value.append(item)
    }
  }
}

// MARK: - Modifier for Child Views, to add to InfoBar
extension View {
  public func addInfoBarItems<T>(
    _ items: T.Type,
    source: T.Source,
    format: DisplayFormat = .default
  ) -> some View
  where T: InfoBarSection & CaseIterable {
    return self.preference(
      key: InfoBarKey.self,
      value: items.items(from: source, format: format)
    )
  }
}
