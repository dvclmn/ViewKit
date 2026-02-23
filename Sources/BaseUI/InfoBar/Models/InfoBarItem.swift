//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

public struct InfoBarItem: Sendable, Equatable, Hashable, Identifiable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel?
  public let content: String

  public init(
    section: InfoBarSectionID,
    label: QuickLabel?,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = section
    self.label = label
    self.content = content
  }
}

extension InfoBarItem {
  /// Allows supplying a SectionKey directly, which is then
  /// implicitly converted to a SectionID
  public init<K: InfoBarSectionKey>(
    section: K.Type,
    label: QuickLabel?,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = InfoBarSectionID(section)
    self.label = label
    self.content = content
  }

  /// Provides a way for DisplayString's Labeled to fit nicely with InfoBar
  /// Really only suitable for `text` and `labeled`. `indented`
  /// would be better suited to constructing *multiple* InfoBarItems
  public init<K: InfoBarSectionKey>(
    fromBlock displayBlock: DisplayBlock,
//    fromLabeled labeled: Labeled,
    section: K.Type = DebugSectionKey.self,
    format: FloatDisplayFormat = .default
  ) {
    let label: String?
    let content: String?
    
    switch displayBlock {
//    let text: String? = switch displayBlock {
      case .text(let atom):
        label = nil
        content = atom.render(using: format)
        
      case .labeled(let key, let separator, let value):
        label = key + separator
        content = value?.render(using: format)

      case .indented(let indented):
        nil // Not sure indented works here?
        
      case .divider(let string):
        nil // Nor divider
    }
    
    guard let text else { return nil }
    self.init(
      text,
      icon: nil,
      role: nil
    )
    
    
    self.init(
      section: section,
      label: QuickLabel(
        fromBlock: displayBlock,
        using: format
      ),
      content: <#T##String#>
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
      content: value
    )
  }
}

extension Array where Element == DisplayBlock {
  func toInfoBarItems<K: InfoBarSectionKey>(
    section: K.Type = DebugSectionKey.self,
    format: FloatDisplayFormat = .default
  ) -> [InfoBarItem] {
//    self.compactMap(\.toInfoBarItem(section: section, using: format))
  }
}

//extension QuickLabel {
//  init?(
//    fromBlock displayBlock: DisplayBlock,
//    using format: FloatDisplayFormat
//  ) {
//
//  }
//}
