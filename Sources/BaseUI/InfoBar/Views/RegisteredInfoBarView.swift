//
//  RegisteredInfoBarView.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/8/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

struct RegisteredInfoBarView: View {
  let store: InfoBarStore

  var body: some View {
    let sections = store.sections

    InfoBarContainer(isEmpty: sections.isEmpty) {
      ForEach(sections) { section in
        RegisteredInfoBarSectionView(section: section)
      }
    }
  }
}

private struct RegisteredInfoBarSectionView: View {
  let section: InfoBarStore.Section

  var body: some View {
    InfoBarSectionContainer(title: section.title) {
      ForEach(section.records) { record in
        RegisteredInfoBarItemView(registration: record.registration)
      }
    }
  }
}

/// This row is the observation boundary for one registration. Updating its content
/// doesn't require `RegisteredInfoBarView` to recompute section discovery or ordering.
private struct RegisteredInfoBarItemView: View {
  let registration: InfoBarRegistration

  var body: some View {
    switch registration.content {
      case .items(let items):
        ForEach(items) { item in
          InfoBarItemView(item: item)
        }
    }
  }
}
