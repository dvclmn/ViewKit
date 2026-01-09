//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import Foundation
import SharedHelpers

public protocol InfoBarSection: CaseIterable {
//  associatedtype Item = AllCases.Element
  associatedtype Source
  //  var elements: [Self.AllCases.Element] { get }
  static var sectionTitle: String { get }
//  var label: QuickLabel { get }
//  var content: AttributedString { get }

//  func buildItems() -> [InfoBarItem]
  static func buildItems(from source: Source) -> [InfoBarItem]
//  static func makeItem(from element: Item) -> InfoBarItem
}
//public protocol InfoBarItemProtocol {
//}

extension InfoBarSection {
//  public func buildItems() -> [InfoBarItem] {
//    Self.allCases.map { item in
//      InfoBarItem(
////        section: Self.section,
//        label: label,
//        content: content
//      )
//    }
//    //    for item in Self.allCases {
//    //
//    //    }
//  }

//  public static func makeItem(from element: ExampleItem) -> InfoBarItem {
//    InfoBarItem(section: <#T##String#>, label: <#T##QuickLabel#>, content: <#T##AttributedString#>)
//  }

}



public struct InfoBarItem: Identifiable, Equatable, Hashable, Sendable {
  public var id: String { label.text }
  public let sectionKey: String
//  public let sectionKey: InfoBar.SectionKey
  public let label: QuickLabel
  public let content: AttributedString

  public init(
    sectionKey: String,
    label: QuickLabel,
    content: AttributedString,
  ) {
    //    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = content
  }

  public init(
    sectionKey: String,
    label: QuickLabel,
    content: String,
  ) {
    self.init(
      sectionKey: sectionKey,
      label: label,
      content: AttributedString(content)
    )
  }

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
