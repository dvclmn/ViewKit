//
//  CardGridSectionTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 14/7/2026.
//

import BaseUI
import CoreTools
import Testing

@Suite("CardGridSection")
struct CardGridSectionTests {

  @Test("grouped keeps each group's source order and honours its declared section order")
  func groupedPreservesItemAndSectionOrder() {
    let items: [SampleItem] = [
      .init(id: 1, group: .line),
      .init(id: 2, group: .dot),
      .init(id: 3, group: .line),
    ]

    let sections = CardGridSection<SampleItem>.grouped(
      items,
      by: \.group,
      order: [.dot, .line],
    )

    #expect(sections.map(\.label.text) == ["Dot", "Line"])
    #expect(sections.map(\.items) == [
      [SampleItem(id: 2, group: .dot)],
      [SampleItem(id: 1, group: .line), SampleItem(id: 3, group: .line)],
    ])
  }

  @Test("grouped appends undeclared groups by their first source occurrence")
  func groupedRetainsGroupsMissingFromDeclaredOrder() {
    let items: [SampleItem] = [
      .init(id: 1, group: .line),
      .init(id: 2, group: .dot),
      .init(id: 3, group: .shape),
    ]

    let sections = CardGridSection<SampleItem>.grouped(
      items,
      by: \.group,
      order: [.dot],
    )

    #expect(sections.map(\.label.text) == ["Dot", "Line", "Shape"])
  }
}

private struct SampleItem: Identifiable, Equatable, LabeledItem {
  let id: Int
  let group: SampleGroup
  let label: LabelDescriptor

  init(id: Int, group: SampleGroup) {
    self.id = id
    self.group = group
    self.label = "Item \(id)"
  }
}

private enum SampleGroup: String, Hashable, LabeledItem {
  case dot
  case line
  case shape
}
