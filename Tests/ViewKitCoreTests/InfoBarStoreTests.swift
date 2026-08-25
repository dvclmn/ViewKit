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

    registration.attach(to: store, in: nil)
    registration.attach(to: store, in: nil)

    #expect(store.records.count == 1)
    #expect(store.records.first?.registration === registration)
  }

  @Test("groups retain first-registration order and item order within each group")
  func groupAndItemOrdering() {
    let store = InfoBarStore()
    let firstAlphaItem = InfoBarRegistration()
    let unsectionedItem = InfoBarRegistration()
    let betaItem = InfoBarRegistration()
    let secondAlphaItem = InfoBarRegistration()
    let alphaID = InfoBarSectionID(AlphaSection.self)
    let betaID = InfoBarSectionID(BetaSection.self)

    store.register(firstAlphaItem, in: alphaID)
    store.register(unsectionedItem, in: nil)
    store.register(betaItem, in: betaID)
    store.register(secondAlphaItem, in: alphaID)

    #expect(store.groups.map(\.id) == [alphaID, nil, betaID])
    #expect(
      store.groups[0].records.map(\.registration.id)
        == [firstAlphaItem.id, secondAlphaItem.id]
    )
    #expect(store.groups[1].records.map(\.registration.id) == [unsectionedItem.id])
  }

  @Test("removing a registration removes its empty section")
  func removalUpdatesSections() {
    let store = InfoBarStore()
    let registration = InfoBarRegistration()

    registration.attach(to: store, in: InfoBarSectionID(AlphaSection.self))
    registration.detach()

    #expect(store.records.isEmpty)
    #expect(store.groups.isEmpty)
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
