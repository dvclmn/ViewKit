//
//  InfoBarItemListView.swift
//  ViewKit
//
//  Created by Dave Coleman on 2/9/2026.
//

import SwiftUI
import ViewKitCore

/// This row is the observation boundary for one registration. Updating its content
/// doesn't require `InfoBarView` to recompute section discovery or ordering.
extension InfoBarView {
  struct ItemListView: View {
    let registration: InfoBarRegistration
    
    var body: some View {
      switch registration.content {
        case .items(let items):
          ForEach(items) { item in
            ItemView(item: item)
          }
      }
    }
  }
}
