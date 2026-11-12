//
//  InfoBarItems+ViewExts.swift
//  ViewKit
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation
import StringTools
import SwiftUI

extension View {
  /// Adds a lightweight, unsectioned text value to the nearest InfoBar presenter.
  ///
  /// This is the preferred path for high-frequency values such as pointer positions.
  /// It preserves the row's identity and updates only its text payload.
  @MainActor
  public func infoBarValue<Value: Equatable>(
    _ value: Value,
    label: LabelDescriptor? = nil,
    isEnabled: Bool = true,
    format: @escaping (Value) -> String = { String(describing: $0) },
  ) -> some View {
    registeringInfoBarValue(
      value,
      label: label,
      sectionID: nil,
      isEnabled: isEnabled,
      format: format,
    )
  }

  /// Adds a lightweight text value to an explicitly named InfoBar section.
  @MainActor
  public func infoBarValue<Value: Equatable, K: InfoBarSectionKey>(
    _ value: Value,
    label: LabelDescriptor? = nil,
    section: K.Type,
    isEnabled: Bool = true,
    format: @escaping (Value) -> String = { String(describing: $0) },
  ) -> some View {
    registeringInfoBarValue(
      value,
      label: label,
      sectionID: InfoBarSectionID(section),
      isEnabled: isEnabled,
      format: format,
    )
  }

  @MainActor
  private func registeringInfoBarValue<Value: Equatable>(
    _ value: Value,
    label: LabelDescriptor?,
    sectionID: InfoBarSectionID?,
    isEnabled: Bool,
    format: @escaping (Value) -> String,
  ) -> some View {
    modifier(
      InfoBarRegistrationModifier(
        value: value,
        sectionID: sectionID,
        isEnabled: isEnabled,
        makeContent: { value in
          .items([
            InfoBarItem(
              label: label,
              content: format(value),
            )
          ])
        },
      )
    )
  }
}

// MARK: - Existing item APIs

extension View {
  /// Adds all cases of an item descriptor to its declared InfoBar section.
  @MainActor
  public func infoBarItems<T>(
    _ items: T.Type,
    source: T.Source,
    format: FloatDisplayFormat = .default,
  ) -> some View
  where T: InfoBarItemDescriptor & CaseIterable {
    registeringInfoBarItems(
      T.items(from: source, format: format),
      sectionID: InfoBarSectionID(T.SectionKey.self),
    )
  }

  /// Adds unsectioned text items to the nearest InfoBar presenter.
  @MainActor
  public func infoBarItems(
    _ items: String...,
    format: FloatDisplayFormat = .default,
  ) -> some View {
    registeringInfoBarItems(
      items.map { InfoBarItem(label: nil, content: $0) },
      sectionID: nil,
    )
  }

  /// Adds text items to an explicitly named InfoBar section.
  @MainActor
  public func infoBarItems<K: InfoBarSectionKey>(
    _ items: String...,
    key: K.Type,
    format: FloatDisplayFormat = .default,
  ) -> some View {
    registeringInfoBarItems(
      items.map { InfoBarItem(label: nil, content: $0) },
      sectionID: InfoBarSectionID(key),
    )
  }

  /// Adds unsectioned display-string items to the nearest InfoBar presenter.
  @MainActor
  public func infoBarItems(
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
    preset: FloatDisplayPreset = .standard,
  ) -> some View {
    registeringInfoBarItems(content().toInfoBarItems(preset: preset), sectionID: nil)
  }

  /// Adds display-string items to an explicitly named InfoBar section.
  @MainActor
  public func infoBarItems<K: InfoBarSectionKey>(
    @DisplayStringBuilder _ content: @escaping () -> [DisplayBlock],
    key: K.Type,
    preset: FloatDisplayPreset = .standard,
  ) -> some View {
    registeringInfoBarItems(
      content().toInfoBarItems(preset: preset),
      sectionID: InfoBarSectionID(key),
    )
  }

  @MainActor
  private func registeringInfoBarItems(
    _ items: [InfoBarItem],
    sectionID: InfoBarSectionID?,
  ) -> some View {
    modifier(
      InfoBarRegistrationModifier(
        value: InfoBarItemsSnapshot(items: items),
        sectionID: sectionID,
        isEnabled: true,
        makeContent: { .items($0.items) },
      )
    )
  }
}
