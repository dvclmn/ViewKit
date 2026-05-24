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

  var labelText: String { get }
  var icon: IconLiteral { get }
  func content(from source: Source) -> String
  //  func content(from source: Source, format: FloatDisplayFormat) -> String
}

extension InfoBarItemDescriptor {

  public var label: QuickLabel { .init(labelText, icon: icon) }
  //  public var labelText: String { label.text }
  //  public var icon: IconLiteral { label.icon }

  public func makeItem(
    from source: Source,
    format: FloatDisplayFormat
  ) -> InfoBarItem {
    InfoBarItem(
      section: InfoBarSectionID(SectionKey.self),
      label: label,
      content: content(from: source)
      //      content: content(from: source, format: format)
    )
  }
}

extension InfoBarItemDescriptor where Self: RawRepresentable, Self.RawValue == String {
  public var text: String { rawValue.capitalized }
}
