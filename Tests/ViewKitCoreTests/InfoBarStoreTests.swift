//
//  InfoBarStoreTests.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import CoreTools
import Testing
@testable import ViewKitCore

@Suite("InfoBarStore")
@MainActor
struct InfoBarStoreTests {
  @Test("registering the same item repeatedly does not change the collection")
  func registrationIsIdempotent() {
    let store = InfoBarStore()
    let registration = InfoBarRegistration()

    registration.attach(to: store, in: InfoBarSectionID(DebugSectionKey.self))
    registration.attach(to: store, in: InfoBarSectionID(DebugSectionKey.self))

    #expect(store.records.count == 1)
    #expect(store.records.first?.registration === registration)
  }

  @Test("sections are sorted while registration order remains stable")
  func sectionAndItemOrdering() {
    let store = InfoBarStore()
    let secondAlphaItem = InfoBarRegistration()
    let betaItem = InfoBarRegistration()
    let firstAlphaItem = InfoBarRegistration()

    store.register(firstAlphaItem, in: InfoBarSectionID(AlphaSection.self))
    store.register(betaItem, in: InfoBarSectionID(BetaSection.self))
    store.register(secondAlphaItem, in: InfoBarSectionID(AlphaSection.self))

    #expect(store.sections.map(\.title) == ["Alpha", "Beta"])
    #expect(
      store.sections[0].records.map(\.registration.id)
        == [firstAlphaItem.id, secondAlphaItem.id]
    )
  }

  @Test("removing a registration removes its empty section")
  func removalUpdatesSections() {
    let store = InfoBarStore()
    let registration = InfoBarRegistration()

    registration.attach(to: store, in: InfoBarSectionID(AlphaSection.self))
    registration.detach()

    #expect(store.records.isEmpty)
    #expect(store.sections.isEmpty)
  }

  @Test("item snapshots ignore transient UUID changes")
  func snapshotsCompareDisplayedContent() {
    let first = InfoBarItemsSnapshot(items: [makeItem(content: "42")])
    let sameDisplay = InfoBarItemsSnapshot(items: [makeItem(content: "42")])
    let changedDisplay = InfoBarItemsSnapshot(items: [makeItem(content: "43")])

    #expect(first == sameDisplay)
    #expect(first != changedDisplay)
  }

  @Test("legacy item updates preserve row identity")
  func itemUpdatesPreserveIdentity() throws {
    let registration = InfoBarRegistration()
    registration.update(to: .items([makeItem(content: "42")]))
    let initialItem = try #require(registration.items.first)

    registration.update(to: .items([makeItem(content: "43")]))
    let updatedItem = try #require(registration.items.first)

    #expect(updatedItem.id == initialItem.id)
    #expect(updatedItem.content == "43")
  }

  private func makeItem(content: String) -> InfoBarItem {
    InfoBarItem(
      section: AlphaSection.self,
      label: LabelDescriptor("Value"),
      content: content
    )
  }
}

extension InfoBarRegistration {
  fileprivate var items: [InfoBarItem] {
    guard case .items(let items) = content else { return [] }
    return items
  }
}

private enum AlphaSection: InfoBarSectionKey {
  static let title = "Alpha"
}

private enum BetaSection: InfoBarSectionKey {
  static let title = "Beta"
}
