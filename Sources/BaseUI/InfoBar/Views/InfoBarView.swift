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

struct InfoBarView<LeadingContent: View, TrailingContent: View>: View {
  let store: InfoBarStore
  let hasAdditionalContent: Bool
  let leadingContent: LeadingContent
  let trailingContent: TrailingContent

  var body: some View {
    InfoBarContainer(isEmpty: groups.isEmpty && !hasAdditionalContent) {
      leadingContent

      ForEach(groups) { group in
        switch group {
          case .unsectioned(let records):
            ItemsView(records: records)

          case .section(let section):
            SectionView(section: section)
        }
      }

      trailingContent
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
