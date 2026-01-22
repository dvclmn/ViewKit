//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

public struct InfoBarItem: LabeledItem, Sendable, Equatable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel

  /// Could one day consider making this more strongly typed,
  /// for content-specific styling such as display format for Floats etc
  ///
  /// Update: Performance in e.g. CanvasKit suffered dramatically
  /// once I implemented this as DisplayBlock
  public let content: String
  //  public let content: DisplayBlock
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
    text: String
  ) {
    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = text
    //    self.content = .text(text)
  }
}
