//
//  InfoBarSection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import CoreTools

/// This is made with an enum in mind.
public protocol InfoBarSection {
  associatedtype Source
  associatedtype SectionKey: InfoBarSectionKey

  /// title and icon provided per-case
  var title: String { get }
  var icon: IconLiteral { get }

  func getContent(
    from source: Source,
    format: DisplayFormat
  ) -> String
}

extension InfoBarSection {
  public var label: QuickLabel { .init(title, icon: icon) }
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
