//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import Foundation

public struct InfoBarItem: Sendable, Equatable, Hashable, Identifiable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel?
  public let columnedContent: ColumnString

  public init(
    id: UUID = UUID(),
    sectionKey: InfoBarSectionID,
    label: QuickLabel?,
    content: ColumnString
  ) {
    self.id = id
    self.sectionKey = sectionKey
    self.label = label
    self.columnedContent = content
  }
}

extension InfoBarItem {
  /// This isn't implemented just yet, it's just a passthrough
  public var content: String { columnedContent.content }
  public init(
    section: InfoBarSectionID,
    label: QuickLabel?,
    content: String,
    columnWidth: ColumnString.Width = .default
  ) {
    self.init(
      sectionKey: section,
      label: label,
      content: ColumnString(stringLiteral: content)
    )
  }

  /// Allows supplying a SectionKey directly, which is then
  /// implicitly converted to a SectionID
  public init<K: InfoBarSectionKey>(
    section: K.Type,
    label: QuickLabel?,
    content: String,
    columnWidth: ColumnString.Width = .default
  ) {
    self.init(
      sectionKey: InfoBarSectionID(section),
      label: label,
      content: ColumnString(stringLiteral: content)
    )
  }

  /// Provides a way for DisplayString's Labeled to fit nicely with InfoBar
  /// Really only suitable for `text` and `labeled`. `indented`
  /// would be better suited to constructing *multiple* InfoBarItems
  public init?<K: InfoBarSectionKey>(
    fromBlock displayBlock: DisplayBlock,
    section: K.Type = DebugSectionKey.self,
    preset: FloatDisplayPreset = .standard,
    columnWidth: ColumnString.Width = .default
  ) {
    switch displayBlock {
      case .text(let fragment):
        self.init(
          section: section,
          label: nil,
          content: fragment.render(using: preset.format)
        )

      case .labeled(let label):
        self.init(fromLabeled: label, section: section, format: preset.format)

      case .indented:
        assertionFailure("Use extension `Array where Element == DisplayBlock` for `indented`.")
        return nil

      case .divider:
        assertionFailure("Divider not suited for display as an InfoBarItem.")
        return nil
    }
  }
}
