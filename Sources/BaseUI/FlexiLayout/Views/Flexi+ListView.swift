//
//  Flexi+ListView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/9/2025.
//

import LayoutKit
import SwiftUI
import SharedHelpers

extension Flexi {
  struct ListView: View {
    @Environment(FlexiHandler<Item>.self) private var store
    @Environment(\.selectionMode) private var selectionMode
//    @Binding var multiSelection: Set<Item.ID>
//    @Binding var singleSelection: Item.ID?
    
    let data: [Item]
//    let groupPath: KeyPath<Item, String>?
//    let selectionMode: FlexiLayout.SelectionMode
    let content: (Item) -> Content

    var body: some View {

      @Bindable var store = store
      switch selectionMode {
        case .single:
//          List(selection: store.selectionBinding(\.singleSelection)) {
          List(selection: $store.singleSelection) {
            GroupedContent()
          }

        case .multi:
          List(selection: $store.multiSelection) {
//          List(selection: store.selectionBinding(\.multiSelection)) {
            GroupedContent()
          }
          
        case .none:
          EmptyView()
      }
    }
  }
}
extension Flexi.ListView {
  @ViewBuilder
  private func GroupedContent() -> some View {
    GroupedView(
      data: data,
      groupedBy: store.groupPath,
    ) { item in
      content(item)
        .compatibleLabelIconSpacing(Styles.sizeSmall.bump)
    }
  }
}


