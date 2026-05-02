//
//  InfoBarSectionProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import BasePrimitives
import CoreUtilities

/// Describes a whole InfoBar Section
public protocol InfoBarSectionProtocol {
  associatedtype Source
  associatedtype Item: InfoBarItemDescriptor where Item.Source == Source

  static var key: InfoBarSectionID { get }
  static func items(from source: Source, format: FloatDisplayFormat) -> [InfoBarItem]
}

extension CaseIterable where Self: InfoBarItemDescriptor {
  public static func items(from source: Source, format: FloatDisplayFormat) -> [InfoBarItem] {
    allCases.map { $0.makeItem(from: source, format: format) }
  }
}
