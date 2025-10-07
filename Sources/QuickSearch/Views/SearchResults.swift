//
//  SearchResults.swift
//  BaseComponents
//
//  Created by Dave Coleman on 21/9/2025.
//

import BaseComponents
import BaseHelpers
import SharedHelpers
import SwiftUI

public struct SearchResults<Handler: FuzzySearchHandler>: View {
  @Environment(\.layoutAxis) private var layoutAxis
  @Binding var store: Handler

  let results: [FuzzyMatch<Handler.Item>]
  public var body: some View {

    Flexi.LayoutView(
      layoutMode: store.layoutMode,
      data: results.map(\.item),
      singleSelection: $store.selectedResult
    ) { item in
      SearchItemView(item)

    }  // END flexi view
    .environment(\.gridColumnMode, .adaptive(.fill(min: 120, max: 160)))
    //        .environment(\.gridColumns, .adaptive(mode: .fill(min: 120, max: 160)))
    .scrollContentBackground(.hidden)
    .toolbar {
      ToolbarItem(placement: .secondaryAction) {
        CycleLayoutMode(mode: $store.layoutMode)
      }
    }
  }
}

extension SearchResults {
  @ViewBuilder
  private func SearchItemView(_ item: Handler.Item) -> some View {
    //    if let item = results.first(where: { $0.item.id == itemID }) {

    switch store.layoutMode {
      case .grid:
        MaybeLabel(item.label)
          .modifier(GridStyleModifier())

      case .list:
        MaybeLabel(item.label)
          .padding(.vertical, Styles.sizeTiny)
          .labelStyle(.base)
          .foregroundStyle(Color.white.tertiary)
          .font(.title3)
    }

    //    }
  }
}
