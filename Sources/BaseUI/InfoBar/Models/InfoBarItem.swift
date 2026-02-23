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
  public init<K: InfoBarSectionKey>(
    fromLabeled labeled: Labeled,
    section: K.Type = DebugSectionKey.self,
    format: DisplayFormat = .default
  ) {
    self.init(
      section: section,
      label: QuickLabel(stringLiteral: labeled.key),
      content: labeled.renderValue(using: format)
    )
  }
}
