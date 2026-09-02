//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation
import StringTools

public struct InfoBarItem: Sendable, Equatable, Hashable, Identifiable {
  public let id: UUID
  public let label: LabelDescriptor?
  public let content: ColumnString

  /// The plain-text representation of the item's content.
  ///
  /// Views should render `content.sourceContent` using the column metadata so
  /// assistive technologies and text selection retain the complete value.
  public var resolvedContent: String { content.resolvedContent }

  public init(
    id: UUID = UUID(),
    label: LabelDescriptor?,
    content: ColumnString,
  ) {
    self.id = id
    self.label = label
    self.content = content
  }
}

extension InfoBarItem {

  public init(
    label: LabelDescriptor?,
    content: String,
    columnWidth: ColumnString.Width = .default,
  ) {
    self.init(
      label: label,
      content: ColumnString(
        content: content,
        width: columnWidth,
      ),
    )
  }

  /// Provides a way for DisplayString's Labeled to fit nicely with InfoBar
  /// Really only suitable for `text` and `labeled`. `indented`
  /// would be better suited to constructing *multiple* ``InfoBarItem``s
  public init?(
    fromBlock displayBlock: DisplayBlock,
    preset: FloatDisplayPreset = .standard,
    columnWidth: ColumnString.Width = .default,
  ) {
    switch displayBlock {
      case .text(let fragment):
        self.init(
          label: nil,
          content: ColumnString(
            content: fragment.render(
              using: preset.format,
              with: .standard,
              delimiter: ", ",
            ),
            width: columnWidth,
          ),
        )

      case .labeled(let label):
        self.init(
          fromLabeled: label,
          format: preset.format,
          columnWidth: columnWidth,
        )

      case .indented:
        assertionFailure("Use extension `Array where Element == DisplayBlock` for `indented`.")
        return nil

      case .divider:
        assertionFailure("Divider not suited for display as an InfoBarItem.")
        return nil
    }
  }

  package func replacingID(with id: UUID) -> Self {
    Self(
      id: id,
      label: label,
      content: content,
    )
  }
}
