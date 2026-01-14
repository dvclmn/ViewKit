//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import BasePrimitives
import Foundation

public protocol InfoBarSection {
  associatedtype Source
  static var sectionTitle: String { get }
  func makeItem(from source: Source) -> InfoBarItem
}

extension InfoBarSection where Self: CaseIterable {
  public static func items(from source: Source) -> [InfoBarItem] {
    Self.allCases.map { $0.makeItem(from: source) }
  }
}

public struct InfoBarItem: Identifiable, Equatable, Hashable, Sendable {
  //public struct InfoBarItem<Section: InfoBarSection>: Identifiable, Equatable, Hashable where Section.Key: Hashable {
  public let id: UUID
//  public var id: String { label.text }
  public let sectionKey: String
  public let label: QuickLabel
  public let content: String
//  public let content: AttributedString

  public init(
    sectionKey: String,
    //    sectionKey: Section.Key,
    label: QuickLabel,
    content: String
//    content: AttributedString,
  ) {
        self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = content
  }

//  public init(
//    sectionKey: String,
//    //    sectionKey: Section.Key,
//    label: QuickLabel,
//    content: String,
//  ) {
//    self.init(
//      sectionKey: sectionKey,
//      label: label,
//      content: AttributedString(content)
//    )
//  }

  //  public static let empty = InfoBarItem(
  //    sectionKey: "Section",
  //    label: QuickLabel("Default label"),
  //    content: ""
  //  )
}

extension InfoBarItem: CustomStringConvertible {
  public var description: String {
    return """
      /// InfoBarItem ///
        - Section: \"\("section")\"
        - Label: \"\(label)\"
        - Content: \"\(content.toString)\"


      """
  }
}
