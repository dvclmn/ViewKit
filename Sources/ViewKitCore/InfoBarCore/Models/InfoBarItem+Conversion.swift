//
//  InfoBarItem+Conversion.swift
//  ViewKit
//
//  Created by Dave Coleman on 9/3/2026.
//

@_spi(Internal) import CoreTools
//@_spi(Internals) import ViewTools
@_spi(Internal) import StringTools

extension InfoBarItem {
  /// `labelStyle` applies style to the value part
  init?<K: InfoBarSectionKey>(
    fromLabeled labeled: Labeled,
    section: K.Type,
    labelStyle: AbbreviableLabel.Style = .standard,
    format: FloatDisplayFormat = .default,
  ) {
    let label = labeled.labelPart()
    guard
      let value = Labeled.valuePart(
        for: labeled,
        using: format,
        with: labelStyle,
      )
    else { return nil }
    self.init(
      section: section,
      label: .init(label),
//      label: label.map { LabelDescriptor(stringLiteral: $0) },
      content: value,
    )
  }
}

extension InfoBarItem: ExpressibleByStringLiteral {
  /// Allows a very simple/flexible way to create an info bar item
  /// Defaults to `DebugSectionKey`, but considering changing
  /// this in future to be a bit more flexible/expressive
  public init(stringLiteral value: String) {
    self.init(
      section: InfoBarSectionID(DebugSectionKey.self),
      label: nil,
      content: value,
    )
  }
}

extension Array where Element == DisplayBlock {
  /// text and labeled can use `init(fromBlock:section:format:)`,
  /// and should return it wrapped in `[singleInfoBarItem]`
  /// indented produces *multiple* Display blocks, `[DisplayBlock]`,
  /// so should map each to an array
  /// divider = []
  func toInfoBarItems<K: InfoBarSectionKey>(
    section: K.Type = DebugSectionKey.self,
    preset: FloatDisplayPreset = .standard,
  ) -> [InfoBarItem] {
    compactMap { block -> [InfoBarItem]? in
      switch block {
        case .text, .labeled:
          guard
            let item = InfoBarItem(
              fromBlock: block,
              section: section,
              preset: preset,
            )
          else { return nil }
          return [item]

        case .indented(let indented):
          return indented.toInfoBarItems(
            section: section,
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
  func toInfoBarItems<K: InfoBarSectionKey>(
    section: K.Type = DebugSectionKey.self,
    preset: FloatDisplayPreset = .standard,
    //    format: FloatDisplayFormat = .default
  ) -> [InfoBarItem] {
    content.compactMap { indentedBlock in
      let item = InfoBarItem(
        fromBlock: indentedBlock,
        section: section,
        preset: preset,
      )
      guard let item else { return nil }
      return item
    }
  }
}
