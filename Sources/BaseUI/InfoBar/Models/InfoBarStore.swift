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
/// The store's collection changes only when an item appears, disappears, or changes
/// section placement. Each registration observes its own displayed content separately,
/// preventing a frequently changing value from invalidating every InfoBar item.
@MainActor
@Observable
package final class InfoBarStore {
  package let id = UUID()

  package private(set) var records: [Record] = []

  package init() {}

  package func register(
    _ registration: InfoBarRegistration,
    in section: InfoBarSectionID?,
  ) {
    if let index = records.firstIndex(where: { $0.id == registration.id }) {
      guard records[index].sectionID != section else { return }
      records[index].sectionID = section
    } else {
      records.append(Record(registration: registration, sectionID: section))
    }
  }

  package func remove(_ registration: InfoBarRegistration) {
    records.removeAll { $0.id == registration.id }
  }

  /// Groups registrations in first-registration order. An unsectioned group is
  /// represented once, at the point where its first item registered.
  package var groups: [Group] {
    var groupOrder: [InfoBarSectionID?] = []
    var seenGroupIDs: Set<InfoBarSectionID?> = []
    var unsectionedRecords: [Record] = []
    var sectionRecords: [InfoBarSectionID: [Record]] = [:]

    for record in records {
      let groupID = record.sectionID
      if seenGroupIDs.insert(groupID).inserted {
        groupOrder.append(groupID)
      }

      if let sectionID = record.sectionID {
        sectionRecords[sectionID, default: []].append(record)
      } else {
        unsectionedRecords.append(record)
      }
    }

    return groupOrder.compactMap { groupID in
      if let sectionID = groupID {
        guard let records = sectionRecords[sectionID] else { return nil }
        return .section(Section(id: sectionID, records: records))
      }

      return .unsectioned(records: unsectionedRecords)
    }
  }
}

extension InfoBarStore {
  package struct Record: Identifiable {
    package var id: UUID { registration.id }
    package let registration: InfoBarRegistration
    package var sectionID: InfoBarSectionID?
  }

  package struct Section: Identifiable {
    package let id: InfoBarSectionID
    package let records: [Record]

    package var title: String { id.title }
  }

  package enum Group: Identifiable {
    case unsectioned(records: [Record])
    case section(Section)

    package var id: InfoBarSectionID? {
      switch self {
        case .unsectioned:
          return nil
        case .section(let section):
          return section.id
      }
    }

    package var records: [Record] {
      switch self {
        case .unsectioned(let records):
          return records
        case .section(let section):
          return section.records
      }
    }
  }
}
