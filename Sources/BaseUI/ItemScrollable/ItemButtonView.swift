//
//  ItemButtonView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 27/8/2025.
//

import CoreTools
import ViewTools
import SwiftUI

struct ItemButton<Content: View, Item: Pickable>: View {
  //struct ItemButton<Content: View, Item: Pickable & Shortcuttable>: View {

  @Binding var scrolledItem: Item
  let item: Item
  let content: (Item) -> Content

  var body: some View {
    Button {
      scrolledItem = item
    } label: {
      content(item)
        .padding(.vertical, Styles.sizeSmall)
        .padding(.horizontal, Styles.sizeSmall)
    }
    .buttonStyle(.plain)
    .id(item.id)
  }
}
