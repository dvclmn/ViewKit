//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

public struct InfoBarItem: LabeledItem, Sendable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel
  
  /// Could one day consider making this more strongly typed,
  /// for content-specific styling such as display format for Floats etc
  public let content: String
}

extension InfoBarItem {
  public init(
    sectionKey: InfoBarSectionID,
    label: QuickLabel,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = content
  }
}
