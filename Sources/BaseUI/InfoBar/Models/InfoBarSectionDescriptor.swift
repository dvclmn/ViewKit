//
//  InfoBarSectionProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools

/// Describes a whole InfoBar Section
public protocol InfoBarSectionProtocol {
  //public protocol InfoBarSectionDescriptor {
  associatedtype Source
  associatedtype Item: InfoBarItemDescriptor where Item.Source == Source

  static var key: InfoBarSectionID { get }
  static func items(from source: Source, format: DisplayFormat) -> [InfoBarItem]
}

extension CaseIterable where Self: InfoBarItemDescriptor {
  public static func items(from source: Source, format: DisplayFormat) -> [InfoBarItem] {
    allCases.map { $0.makeItem(from: source, format: format) }
  }
}

//public protocol InfoBarSection {
//  associatedtype Source
//  associatedtype SectionKey: InfoBarSectionKey
//
//  /// title and icon provided per-case
//  var labelText: String { get }
//  var icon: IconLiteral { get }
//
//  func getContent(
//    from source: Source,
//    format: DisplayFormat
//  ) -> String
//}

//extension InfoBarSectionProtocol {
//  public var label: QuickLabel { .init(labelText, icon: icon) }
//}



//extension InfoBarSectionProtocol where Self: CaseIterable {
//  public static func items(
//    from source: Source,
//    format: DisplayFormat = .default
//  ) -> [InfoBarItem] {
//    Self.allCases.map { thing in
//      InfoBarItem(
//        section: InfoBarSectionID(SectionKey.self),
//        label: label,
//        content: thing.getContent(from: source, format: format)
//      )
//    }
//  }
//}
