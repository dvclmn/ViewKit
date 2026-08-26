//
//  InfoBarView.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

struct InfoBarView: View {
  let store: InfoBarStore

  var body: some View {
    InfoBarContainer(isEmpty: groups.isEmpty) {
      ForEach(groups) { group in
        switch group {
          case .unsectioned(let records):
            ItemsView(records: records)

          case .section(let section):
            InfoBarView.SectionView(section: section)
        }
      }
    }
  }
}

extension InfoBarView {
  private var groups: [InfoBarStore.Group] { store.groups }

  @ViewBuilder
  private func ItemsView(records: [InfoBarStore.Record]) -> some View {
    ForEach(records) { record in
      ItemListView(registration: record.registration)
    }
  }
}
