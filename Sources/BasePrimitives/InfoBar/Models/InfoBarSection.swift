//
//  InfoBarSecton.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/2/2026.
//

/// Small helper struct for  processed InfoBar data
public struct InfoBarSection: Identifiable, Sendable {
  public let id: InfoBarSectionID
  public let title: String
  public let items: [InfoBarItem]

  public init(id: InfoBarSectionID, title: String, items: [InfoBarItem]) {
    self.id = id
    self.title = title
    self.items = items
  }
}

extension InfoBarSection {
  public static let exampleSection: Self = .init(
    id: .exampleID,
    title: "Example",
    items: [
      .init(
        section: .exampleID,
        label: "Item Label: ",
        content: "10 x 30 mm"
      ),
      .init(
        section: .exampleID,
        label: "Second: ",
        content: "x: 43, y: 12"
      ),
      .init(
        section: .exampleID,
        label: "Third thing: ",
        content: "200 char."
      ),
    ]
  )
}
