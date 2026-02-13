//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

public struct InfoBarItem: LabeledItem, Sendable, Equatable, Hashable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel

  /// Could one day consider making this more strongly typed,
  /// for content-specific styling such as display format for Floats etc
  ///
  /// Update: Performance in e.g. CanvasKit suffered dramatically
  /// once I implemented this as DisplayBlock
  public let content: String

  public init(
    section: InfoBarSectionID,
    label: QuickLabel,
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
    label: QuickLabel,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = InfoBarSectionID(section)
    self.label = label
    self.content = content
  }
}

extension InfoBarItem {
  public enum ContentKind {
    case text(String)
    case floatLabeled(PropertiesLabeled)
  }
}
