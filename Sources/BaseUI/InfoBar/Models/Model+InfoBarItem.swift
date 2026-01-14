//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import CoreTools
import Foundation

/// This is made with an enum in mind.
public protocol InfoBarSection {
  associatedtype Source
  associatedtype SectionKey: InfoBarSectionKey
  /// Provided per-case, e.g. for `case canvasSize`:
  /// `QuickLabel("Canvas Size")`
//  var label: QuickLabel { get }
  var title: String { get }
  var icon: IconLiteral { get }
//  static var sectionKey: SectionKey { get }

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
//        sectionKey: Self.sectionKey,
        label: thing.label,
        content: thing.getContent(from: source, format: format)
      )
    }
  }
}

//public protocol InfoBarItemProtocol: LabeledItem {
////  var id: UUID { get }
////  var sectionKey: String { get }
////  var label: QuickLabel { get }
//  var content: String { get }
//}
//extension InfoBarSection where Self.Item == InfoBarItem {
//
//}


//public struct InfoBarItem<Key: InfoBarSectionKey>: LabeledItem, Sendable {
  public struct InfoBarItem: LabeledItem, Sendable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  //  public let sectionKey: AnyInfoBarSectionKey
  //  public let sectionKey: String
  public let label: QuickLabel
  public let content: String
}

extension InfoBarItem {
  public init(
    sectionKey: InfoBarSectionID,
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
