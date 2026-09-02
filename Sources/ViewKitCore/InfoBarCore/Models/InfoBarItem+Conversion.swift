//
//  InfoBarItem+Conversion.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/3/2026.
//

@_spi(Internal) import CoreTools
@_spi(Internal) import StringTools

extension InfoBarItem {
  /// `labelStyle` applies style to the value part
  init?(
    fromLabeled labeled: Labeled,
    labelStyle: AbbreviableLabel.Style = .standard,
    format: FloatDisplayFormat = .default,
    columnWidth: ColumnString.Width = .default,
  ) {
    let label = labeled.labelPart(with: labelStyle)
    guard
      let value = Labeled.valuePart(
        for: labeled,
        using: format,
        with: labelStyle,
      )
    else { return nil }
    self.init(
      label: .init(label),
      content: ColumnString(
        content: value,
        width: columnWidth,
      ),
    )
  }
}

extension InfoBarItem: ExpressibleByStringLiteral {
  /// Allows a simple string to create an unsectioned InfoBar item.
  public init(stringLiteral value: String) {
    self.init(
      label: nil,
      content: value,
    )
  }
}

extension Array where Element == DisplayBlock {
  /// text and labeled can use `init(fromBlock:preset:)`,
  /// and should return it wrapped in `[singleInfoBarItem]`
  /// indented produces *multiple* Display blocks, `[DisplayBlock]`,
  /// so should map each to an array
  /// divider = []
  package func toInfoBarItems(
    preset: FloatDisplayPreset = .standard,
  ) -> [InfoBarItem] {
    compactMap { block -> [InfoBarItem]? in
      switch block {
        case .text, .labeled:
          guard
            let item = InfoBarItem(
              fromBlock: block,
              preset: preset,
            )
          else { return nil }
          return [item]

        case .indented(let indented):
          return indented.toInfoBarItems(
            preset: preset,
          )

        case .divider:
          return nil
      }
    }
    .flatMap(\.self)
  }
}

extension Indented {
  func toInfoBarItems(
    preset: FloatDisplayPreset = .standard,
  ) -> [InfoBarItem] {
    content.compactMap { indentedBlock in
      let item = InfoBarItem(
        fromBlock: indentedBlock,
        preset: preset,
      )
      guard let item else { return nil }
      return item
    }
  }
}
