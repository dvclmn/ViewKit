//
//  InfoBarStore.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import Foundation
import Observation
import SwiftUI

/// Stable registration storage shared by an InfoBar presenter and its descendants.
///
/// The store's collection changes only when an item appears, disappears, or moves to
/// another section. Each registration observes its own displayed content separately,
/// preventing a frequently changing value from invalidating every InfoBar item.
@MainActor
@Observable
package final class InfoBarStore {
  package let id = UUID()

  package private(set) var records: [Record] = []

  package init() {}

  package func register(
    _ registration: InfoBarRegistration,
    in section: InfoBarSectionID
  ) {
    if let index = records.firstIndex(where: { $0.id == registration.id }) {
      guard records[index].sectionKey != section else { return }
      records[index].sectionKey = section
    } else {
      records.append(Record(registration: registration, sectionKey: section))
    }
  }

  package func remove(_ registration: InfoBarRegistration) {
    records.removeAll { $0.id == registration.id }
  }

  package var sections: [Section] {
    let sectionKeys = Set(records.map(\.sectionKey))

    return sectionKeys
      .sorted { $0.title.localizedStandardCompare($1.title) == .orderedAscending }
      .map { sectionKey in
        Section(
          id: sectionKey,
          records: records.filter { $0.sectionKey == sectionKey }
        )
      }
  }
}

extension InfoBarStore {
  package struct Record: Identifiable {
    package var id: UUID { registration.id }
    package let registration: InfoBarRegistration
    package var sectionKey: InfoBarSectionID
  }

  package struct Section: Identifiable {
    package let id: InfoBarSectionID
    package let records: [Record]

    package var title: String { id.title }
  }
}

/// The independently observable content for one modifier attached in the source tree.
@MainActor
@Observable
package final class InfoBarRegistration: Identifiable {
  package let id = UUID()
  package private(set) var content: Content = .items([])
  @ObservationIgnored private weak var registeredStore: InfoBarStore?
  @ObservationIgnored private var registeredSection: InfoBarSectionID?

  package init() {}

  package func update(to newContent: Content) {
    switch (content, newContent) {
      case (.items(let existingItems), .items(let newItems)):
        content = .items(newItems.preservingIDs(from: existingItems))

      default:
        content = newContent
    }
  }

  package func attach(
    to store: InfoBarStore,
    in section: InfoBarSectionID
  ) {
    guard registeredStore !== store || registeredSection != section else { return }

    if registeredStore !== store {
      registeredStore?.remove(self)
      registeredStore = store
    }

    registeredSection = section
    store.register(self, in: section)
  }

  package func detach() {
    registeredStore?.remove(self)
    registeredStore = nil
    registeredSection = nil
  }
}

extension InfoBarRegistration {
  package enum Content {
    case items([InfoBarItem])
  }
}

extension Array where Element == InfoBarItem {
  fileprivate func preservingIDs(from existingItems: [InfoBarItem]) -> [InfoBarItem] {
    enumerated().map { index, item in
      guard existingItems.indices.contains(index) else { return item }
      return item.replacingID(with: existingItems[index].id)
    }
  }
}
