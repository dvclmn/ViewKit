//
//  Model+InfoBarItem.swift
//  BaseComponents
//
//  Created by Dave Coleman on 7/7/2025.
//

// import BaseHelpers
import Foundation

public struct InfoBarItem: Identifiable, Equatable, Hashable, Sendable {
  public var id: String { label.text }
  public let section: String
  public let label: QuickLabel
  public let content: AttributedString

  public init(
    section: String,
    label: QuickLabel,
    content: AttributedString,
  ) {
    //    self.id = UUID()
    self.section = section
    self.label = label
    self.content = content
  }

  public init(
    section: String,
    label: QuickLabel,
    content: String,
  ) {
    self.init(section: section, label: label, content: AttributedString(content))
  }

  public static let empty = InfoBarItem(
    section: "Section",
    label: QuickLabel("Default label"),
    content: ""
  )
}

extension InfoBarItem: CustomStringConvertible {
  public var description: String {
    return """
      /// InfoBarItem ///
        - Section: \"\(section)\"
        - Label: \"\(label)\"
        - Content: \"\(content.toString)\"


      """
  }
}
