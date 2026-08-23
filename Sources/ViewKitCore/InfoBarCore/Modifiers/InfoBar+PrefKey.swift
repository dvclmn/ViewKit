//
//  InfoBar+PrefKey.swift
//  ViewKit
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation
import StringTools
import SwiftUI

// MARK: - Legacy preference compatibility

/// The original InfoBar discovery preference.
///
/// Prefer ``SwiftUI/View/infoBarItem(_:section:isEnabled:content:)`` or the
/// existing `addInfoBarItems` modifiers, which now use stable registrations.
public struct InfoBarKey: PreferenceKey {
  public static let defaultValue: [InfoBarItem] = []

  public static func reduce(
    value: inout [InfoBarItem],
    nextValue: () -> [InfoBarItem]
  ) {
    value.append(contentsOf: nextValue())
  }
}

// MARK: - Stable registration

private struct InfoBarRegistrationTrigger<Value: Equatable>: Equatable {
  let value: Value
  let sectionKey: InfoBarSectionID
  let isEnabled: Bool
  let storeID: UUID?
}

package struct InfoBarItemsSnapshot: Equatable {
  package let items: [InfoBarItem]

  package init(items: [InfoBarItem]) {
    self.items = items
  }

  package static func == (lhs: Self, rhs: Self) -> Bool {
    guard lhs.items.count == rhs.items.count else { return false }

    return zip(lhs.items, rhs.items).allSatisfy { lhsItem, rhsItem in
      lhsItem.sectionKey == rhsItem.sectionKey
        && lhsItem.label == rhsItem.label
        && lhsItem.columnedContent == rhsItem.columnedContent
    }
  }
}

// MARK: - Rich item APIs

extension View {
  /// Adds independently updating view content to the nearest InfoBar presenter.
  ///
  /// Include every changing input in `value`. InfoBar rebuilds the supplied content
  /// only when that equatable value changes, and only the corresponding bar item is
  /// invalidated. The content can contain any SwiftUI view, including controls.
  ///
  /// ```swift
  /// CanvasView()
  ///   .infoBarItem(pointerPosition, section: PointerSection.self) { position in
  ///     Label(position.formatted(), systemImage: "cursorarrow.motionlines")
  ///   }
  /// ```
  @MainActor
  public func infoBarItem<
    Value: Equatable,
    ItemContent: View,
    K: InfoBarSectionKey
  >(
    _ value: Value,
    section: K.Type = DebugSectionKey.self,
    isEnabled: Bool = true,
    @ContentBuilder content: @escaping (Value) -> ItemContent
  ) -> some View {
    modifier(
      InfoBarRegistrationModifier(
        value: value,
        sectionKey: InfoBarSectionID(section),
        isEnabled: isEnabled,
        makeContent: { value in .view(AnyView(content(value))) }
      )
    )
  }

  /// Adds view content that observes its own state to the nearest InfoBar presenter.
  ///
  /// Use the value-taking overload when the builder captures a changing value from
  /// the modified view. This overload builds once per registration and is intended
  /// for static content or a child view that observes a binding or observable model.
  @MainActor
  public func infoBarItem<ItemContent: View, K: InfoBarSectionKey>(
    section: K.Type = DebugSectionKey.self,
    isEnabled: Bool = true,
    @ContentBuilder content: @escaping () -> ItemContent
  ) -> some View {
    modifier(
      InfoBarRegistrationModifier(
        value: isEnabled,
        sectionKey: InfoBarSectionID(section),
        isEnabled: isEnabled,
        makeContent: { _ in .view(AnyView(content())) }
      )
    )
  }

  /// Adds a lightweight text value to the nearest InfoBar presenter.
  ///
  /// This is the preferred path for high-frequency values such as pointer positions.
  /// It preserves the row's identity and updates only its text payload.
  @MainActor
  public func infoBarValue<Value: Equatable, K: InfoBarSectionKey>(
    _ value: Value,
    label: LabelDescriptor? = nil,
    section: K.Type = DebugSectionKey.self,
    isEnabled: Bool = true,
    format: @escaping (Value) -> String = { String(describing: $0) }
  ) -> some View {
    modifier(
      InfoBarRegistrationModifier(
        value: value,
        sectionKey: InfoBarSectionID(section),
        isEnabled: isEnabled,
        makeContent: { value in
          .items([
            InfoBarItem(
              section: section,
              label: label,
              content: format(value)
            )
          ])
        }
      )
    )
  }
}

// MARK: - Existing item APIs

extension View {
  /// Adds all cases of an item descriptor to the nearest InfoBar presenter.
  @MainActor
  public func addInfoBarItems<T>(
    _ items: T.Type,
    source: T.Source,
    format: FloatDisplayFormat = .default
  ) -> some View
  where T: InfoBarItemDescriptor & CaseIterable {
    let currentItems = items.items(from: source, format: format)
    let sectionKey = currentItems.first?.sectionKey ?? InfoBarSectionID(T.SectionKey.self)

    return modifier(
      InfoBarRegistrationModifier(
        value: InfoBarItemsSnapshot(items: currentItems),
        sectionKey: sectionKey,
        isEnabled: true,
        makeContent: { .items($0.items) }
      )
    )
  }

  /// Adds text items to the nearest InfoBar presenter.
  @MainActor
  public func addInfoBarItems<K: InfoBarSectionKey>(
    _ items: String...,
    key: K.Type = DebugSectionKey.self,
    format: FloatDisplayFormat = .default
  ) -> some View {
    let currentItems = items.map { text in
      InfoBarItem(
        section: key,
        label: LabelDescriptor(stringLiteral: ""),
        content: text
      )
    }

    return modifier(
      InfoBarRegistrationModifier(
        value: InfoBarItemsSnapshot(items: currentItems),
        sectionKey: InfoBarSectionID(key),
        isEnabled: true,
        makeContent: { .items($0.items) }
      )
    )
  }

  /// Adds display-string items to the nearest InfoBar presenter.
  @MainActor
  public func addInfoBarItems<K: InfoBarSectionKey>(
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
    key: K.Type = DebugSectionKey.self,
    preset: FloatDisplayPreset = .standard
  ) -> some View {
    let currentItems = content().toInfoBarItems(section: key, preset: preset)

    return modifier(
      InfoBarRegistrationModifier(
        value: InfoBarItemsSnapshot(items: currentItems),
        sectionKey: InfoBarSectionID(key),
        isEnabled: true,
        makeContent: { .items($0.items) }
      )
    )
  }
}
