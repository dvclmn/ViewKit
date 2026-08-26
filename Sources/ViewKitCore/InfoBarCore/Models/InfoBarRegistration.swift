//
//  InfoBarRegistration.swift
//  ViewKit
//
//  Created by Dave Coleman on 26/8/2026.
//

import SwiftUI

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
    }
  }
  
  package func attach(
    to store: InfoBarStore,
    in section: InfoBarSectionID?,
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
