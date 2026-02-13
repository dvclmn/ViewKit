//
//  InfoBarItemDescriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/2/2026.
//

import Foundation
import CoreTools

/// Describes a single InfoBar Item
public protocol InfoBarItemDescriptor {
  associatedtype Source
  associatedtype SectionKey: InfoBarSectionKey
  
  var label: QuickLabel { get }
  func content(from source: Source, format: DisplayFormat) -> String
}

public extension InfoBarItemDescriptor {
  // Convenience if you like your current split:
  var labelText: String { label.text }
  var icon: IconLiteral { label.icon } // if QuickLabel has that
  
  func makeItem(from source: Source, format: DisplayFormat) -> InfoBarItem {
    InfoBarItem(
      id: UUID(),
      sectionKey: InfoBarSectionID(SectionKey.self),
      label: label,
      content: content(from: source, format: format)
    )
  }
  
  public func makeItem(from source: Source, format: DisplayFormat) -> InfoBarItem {
    InfoBarItem(
      section: InfoBarSectionID(SectionKey.self),
      label: label,
      content: content(from: source, format: format)
    )
    //    InfoBarItem(
    //      id: UUID(),
    //      sectionKey: InfoBarSectionID(SectionKey.self),
    //      label: label,
    //      content: content(from: source, format: format)
    //    )
  }
}
