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

  /// Note: ColumnString isn't implemented just yet,
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
      content: ColumnString(stringLiteral: content),
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
          content: fragment.render(using: preset.format, with: .standard, delimiter: ", "),
        )

      case .labeled(let label):
        self.init(fromLabeled: label, format: preset.format)

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
