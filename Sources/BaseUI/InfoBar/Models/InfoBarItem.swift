//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

public struct InfoBarItem: LabeledItem {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel
  
  /// Could one day consider making this more strongly typed,
  /// for content-specific styling such as display format for Floats etc
//  public let content: String
  public let content: DisplayBlock
}
extension InfoBarItem {
  public var plainText: String {
    content
  }
}
extension InfoBarItem {
  public enum ContentKind {
    case text(String)
    case floatLabeled(PropertiesLabeled)
  }
}

extension InfoBarItem {
  public init(
    sectionKey: InfoBarSectionID,
    label: QuickLabel,
    content: DisplayBlock
  ) {
    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = content
  }
  
  public init(
    sectionKey: InfoBarSectionID,
    label: QuickLabel,
    text: String
  ) {
    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = .text(text)
  }
}
