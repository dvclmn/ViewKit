//
//  InfoBarSection.swift
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

/// Describes a single InfoBar Item
public protocol InfoBarItemDescriptor {
  associatedtype Source
  associatedtype SectionKey: InfoBarSectionKey

  var label: QuickLabel { get }
  func content(from source: Source, format: DisplayFormat) -> String
}

extension InfoBarItemDescriptor {

  public func makeItem(from source: Source, format: DisplayFormat) -> InfoBarItem {
    InfoBarItem(sectionKey: <#T##InfoBarSectionID#>, label: <#T##QuickLabel#>, content: <#T##String#>)
//    InfoBarItem(
//      id: UUID(),
//      sectionKey: InfoBarSectionID(SectionKey.self),
//      label: label,
//      content: content(from: source, format: format)
//    )
  }
}

/// Small helper struct for  processed InfoBar data
public struct InfoBarSection: Identifiable {
  public let id: InfoBarSectionID
  let title: String
  let items: [InfoBarItem]
}

extension CaseIterable where Self: InfoBarSectionProtocol {
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

extension InfoBarSection {
  public var label: QuickLabel { .init(labelText, icon: icon) }
}

extension InfoBarSection where Self: RawRepresentable, Self.RawValue == String {
  public var text: String { rawValue.capitalized }
}

extension InfoBarSection where Self: CaseIterable {
  public static func items(
    from source: Source,
    format: DisplayFormat = .default
  ) -> [InfoBarItem] {
    Self.allCases.map { thing in
      InfoBarItem(
        sectionKey: InfoBarSectionID(SectionKey.self),
        label: thing.label,
        content: thing.getContent(from: source, format: format)
      )
    }
  }
}
