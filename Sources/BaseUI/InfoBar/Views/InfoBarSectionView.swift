//
//  InfoBarSectionView.swift
//  ViewKit
//
//  Created by Dave Coleman on 27/6/2025.
//

import SwiftUI
import ViewKitCore

extension InfoBarView {

  struct SectionView: View {

    let section: InfoBarStore.Section

    var body: some View {
      InfoBarSectionContainer(title: section.title) {
        ForEach(section.records) { record in
          ItemListView(registration: record.registration)
        }
      }
    }
  }
}
