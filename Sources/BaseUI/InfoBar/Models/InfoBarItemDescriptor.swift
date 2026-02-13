//
//  InfoBarItemDescriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/2/2026.
//

import CoreTools
import Foundation

/// Describes a single InfoBar Item
public protocol InfoBarItemDescriptor {
  associatedtype Source
  associatedtype SectionKey: InfoBarSectionKey

  var labelText: String { get }
  var icon: IconLiteral { get }
  func content(from source: Source, format: DisplayFormat) -> String
}

extension InfoBarItemDescriptor {

  public var label: QuickLabel { .init(labelText, icon: icon) }
  //  public var labelText: String { label.text }
  //  public var icon: IconLiteral { label.icon }

  public func makeItem(from source: Source, format: DisplayFormat) -> InfoBarItem {
    InfoBarItem(
      section: InfoBarSectionID(SectionKey.self),
      label: label,
      content: content(from: source, format: format)
    )
  }
}

extension InfoBarItemDescriptor where Self: RawRepresentable, Self.RawValue == String {
  public var text: String { rawValue.capitalized }
}
