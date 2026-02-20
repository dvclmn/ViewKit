//
//  InfoBar+DisplayString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/2/2026.
//

import Foundation
import CoreTools

/// Allows InfoBar to use DisplayString to render items
public protocol InfoBarItemConvertible {
  func asInfoBarItem<K: InfoBarSectionKey>(
    section: K.Type,
    format: DisplayFormat
  ) -> InfoBarItem?
}

extension Labeled: InfoBarItemConvertible {
  public func asInfoBarItem<K: InfoBarSectionKey>(
    section: K.Type,
    format: DisplayFormat
  ) -> InfoBarItem? {
    InfoBarItem(
      section: section,
      label: QuickLabel(stringLiteral: key),
      content: value?.render(using: format) ?? "Didn't work?"
    )
  }
}
//extension Array where Element == DisplayBlock {
//  func infoBarItems(
//    section: InfoBarSectionID,
//    format: DisplayFormat
//  ) -> [InfoBarItem] {
//    flatMap { $0.infoBarItems(section: section, format: format) }
//  }
//}
