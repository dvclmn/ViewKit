//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

import Foundation

public struct InfoBarItem: Sendable, Equatable, Hashable, Identifiable {
  public let id: UUID
  public let sectionKey: InfoBarSectionID
  public let label: QuickLabel?
  public let content: String

  public init(
    section: InfoBarSectionID,
    label: QuickLabel?,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = section
    self.label = label
    self.content = content
  }
}

extension InfoBarItem {
  /// Allows supplying a SectionKey directly, which is then
  /// implicitly converted to a SectionID
  public init<K: InfoBarSectionKey>(
    section: K.Type,
    label: QuickLabel?,
    content: String
  ) {
    self.id = UUID()
    self.sectionKey = InfoBarSectionID(section)
    self.label = label
    self.content = content
  }

  /// Provides a way for DisplayString's Labeled to fit nicely with InfoBar
  /// Really only suitable for `text` and `labeled`. `indented`
  /// would be better suited to constructing *multiple* InfoBarItems
  public init?<K: InfoBarSectionKey>(
    fromBlock displayBlock: DisplayBlock,
    section: K.Type = DebugSectionKey.self,
    preset: FloatDisplayPreset = .standard
  ) {
    switch displayBlock {
      case .text(let atom):
        self.init(
          section: section,
          label: nil,
          content: atom.render(using: preset.format)
        )

      case .labeled(let label):
        self.init(fromLabeled: label, section: section, format: preset.format)

      case .indented:
        assertionFailure("Use extension `Array where Element == DisplayBlock` for `indented`.")
        return nil

      case .divider:
        assertionFailure("Divider not suited for display as an InfoBarItem.")
        return nil
    }
  }
}

//extension Array where Element == DisplayBlock {
//  func toInfoBarItems<K: InfoBarSectionKey>(
//    section: K.Type = DebugSectionKey.self,
//    format: FloatDisplayFormat = .default
//  ) -> [InfoBarItem] {
//
//    map { block in
//
//      if let block ==
////      switch block {
////        //        case .text(let displayAtom):
////
////        //        case .labeled(let key, let separator, let value):
////
////        case .indented(let indented):
////          let item = indented.content.compactMap { indentedBlock in
////            if let item = InfoBarItem(fromBlock: indentedBlock, section: section, format: format) {
////              return item
////            }
////            return nil
////          }
////
////        case .divider(let string):
////          return nil
////
////        default:
////          return InfoBarItem(fromBlock: block, section: section, format: format) ?? []
////      }
//    }
//    //    let thing = compactMap { block in
//    //      switch block {
//    //        case .indented(let indented):
//    //          indented.content.map { indented in
//    ////          let thing = indented.content.map { indented in
//    //            InfoBarItem(fromBlock: indented, section: section, format: format)
//    //            //            let item = InfoBarItem(fromBlock: indented, section: section, format: format)
//    //            //            guard let item else { return nil }
//    //
//    //          }
//    //        case .divider(let string):
//    //          []
//    //
//    //        default:
//    //          InfoBarItem(fromBlock: block, section: section, format: format)
//    //      }
//    //    }
//    //    self.compactMap(\.toInfoBarItem(section: section, using: format))
//  }
//}

//extension QuickLabel {
//  init?(
//    fromBlock displayBlock: DisplayBlock,
//    using format: FloatDisplayFormat
//  ) {
//
//  }
//}
