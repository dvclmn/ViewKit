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
  associatedtype Item: InfoBarItemProtocol
  static var sectionTitle: String { get }
  func makeItem(from source: Source) -> Item
}

extension InfoBarSection where Self: CaseIterable {
  public static func items(from source: Source) -> [Item] {
    Self.allCases.map { $0.makeItem(from: source) }
  }
}

public protocol InfoBarItemProtocol: LabeledItem {
//  var id: UUID { get }
  var sectionKey: String { get }
//  var label: QuickLabel { get }
  var content: String { get }
}


public struct InfoBarItem: InfoBarItemProtocol {
  public let id: UUID
  public let sectionKey: String
  public let label: QuickLabel
  public let content: String
  
  public init(
    sectionKey: String,
    label: QuickLabel,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = sectionKey
    self.label = label
    self.content = content
  }
}
//
//  public init(
//    sectionKey: String,
//    //    sectionKey: Section.Key,
//    label: QuickLabel,
//    content: String
//      //    content: AttributedString,
//  ) {
//    self.id = UUID()
//    self.sectionKey = sectionKey
//    self.label = label
//    self.content = content
//  }
//
//  //  public init(
//  //    sectionKey: String,
//  //    //    sectionKey: Section.Key,
//  //    label: QuickLabel,
//  //    content: String,
//  //  ) {
//  //    self.init(
//  //      sectionKey: sectionKey,
//  //      label: label,
//  //      content: AttributedString(content)
//  //    )
//  //  }
//
//  //  public static let empty = InfoBarItem(
//  //    sectionKey: "Section",
//  //    label: QuickLabel("Default label"),
//  //    content: ""
//  //  )
//}

//extension InfoBarItem: CustomStringConvertible {
//  public var description: String {
//    return """
//      /// InfoBarItem ///
//        - Section: \"\("section")\"
//        - Label: \"\(label)\"
//        - Content: \"\(content.toString)\"
//
//
//      """
//  }
//}
