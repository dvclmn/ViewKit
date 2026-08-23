//
//  InfoBar+OnPrefChange.swift
//  ViewKit
//
//  Created by Dave Coleman on 11/1/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore

@MainActor
struct InfoBarItemsModifier: ViewModifier {
  @Environment(\.infoBarStore) private var inheritedStore
  @State private var ownedStore = InfoBarStore()
  //  @State private var preferenceBridge = InfoBarPreferenceBridge()

  let isEnabled: Bool

  func body(content: Content) -> some View {
    let activeStore = activeStore

    content
      .environment(\.infoBarStore, activeStore)
      .environment(\.isInfoBarPresent, shouldPresent || inheritedStore != nil)
      //      .onPreferenceChange(InfoBarKey.self) { items in
      //        guard inheritedStore == nil else { return }
      //        preferenceBridge.update(items, in: ownedStore)
      //      }
      .safeAreaInset(edge: .bottom, spacing: 0) {
        if shouldPresent {
          RegisteredInfoBarView(store: ownedStore)
        }
      }
      .onAppear {
        #if DEBUG
        if isEnabled, inheritedStore != nil {
          print(
            "⚠️ Warning: Duplicate InfoBarModifier detected at this view level. Child InfoBar is being suppressed."
          )
        }
        #endif
      }
  }

  private var activeStore: InfoBarStore? {
    if let inheritedStore {
      inheritedStore
    } else if isEnabled {
      ownedStore
    } else {
      nil
    }
  }

  private var shouldPresent: Bool {
    isEnabled && inheritedStore == nil
  }
}

//@MainActor
//private final class InfoBarPreferenceBridge {
//  private var registrations: [InfoBarSectionID: InfoBarRegistration] = [:]
//  private var snapshots: [InfoBarSectionID: InfoBarItemsSnapshot] = [:]
//
//  func update(_ items: [InfoBarItem], in store: InfoBarStore) {
//    var seenIDs: Set<InfoBarItem.ID> = []
//    let uniqueItems = items.filter { seenIDs.insert($0.id).inserted }
//    let groupedItems = Dictionary(grouping: uniqueItems, by: \.sectionKey)
//    let removedSectionKeys = Set(registrations.keys).subtracting(groupedItems.keys)
//
//    for sectionKey in removedSectionKeys {
//      guard let registration = registrations.removeValue(forKey: sectionKey) else { continue }
//      snapshots.removeValue(forKey: sectionKey)
//      registration.detach()
//    }
//
//    for (sectionKey, sectionItems) in groupedItems {
//      let registration = registrations[sectionKey] ?? InfoBarRegistration()
//      let snapshot = InfoBarItemsSnapshot(items: sectionItems)
//
//      if snapshots[sectionKey] != snapshot {
//        registration.update(to: .items(sectionItems))
//        snapshots[sectionKey] = snapshot
//      }
//
//      registrations[sectionKey] = registration
//      registration.attach(to: store, in: sectionKey)
//    }
//  }
//}

