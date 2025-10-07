//
//  QuickSearchView.swift
//  BaseComponents
//
//  Created by Dave Coleman on 25/5/2025.
//

import BaseComponents
import BaseHelpers
import SwiftUI
import SharedHelpers

public struct QuickSearchView<Handler: FuzzySearchHandler>: View {

  public typealias Item = Handler.Item
  @Binding var store: Handler
  let axis: Axis
  let onItemTap: (Item.ID) -> Void

  public init(
    store: Binding<Handler>,
    axis: Axis = .vertical,
    onItemTap: @escaping (Item.ID) -> Void
  ) {
    self._store = store
    self.axis = axis
    self.onItemTap = onItemTap
  }

  public var body: some View {

    Group {
      if let state = store.searchState {

        ZStack(alignment: .top) {

          Color.black.opacityLow

          ZStack {
            switch state {
              case .noSearchString:

                StateView(
                  "Enter a search, to search your search.",
                  icon: .symbol(Icons.binoculars.icon)
                )
                .controlSize(.small)

              case .searching(let results):
                switch results {
                  case .loading:
                    StateView("Loading results...")
                      .environment(\.isCompactMode, true)

                  case .noResults:
                    StateView("No results found", message: "Try a different search query.")
                      .environment(\.isCompactMode, true)

                  case .hasResults(let items):
                    SearchResults(store: $store, results: items)
                }
            }
          }  // END state group

          .frame(
            maxWidth: .infinity,
            maxHeight: maxHeight,
            alignment: .top
          )
          .environment(\.layoutAxis, axis)
          .safeAreaPadding(.bottom, Styles.sizeRegular)
          .glassEffectCompatible(.rect(cornerRadius: Styles.sizeMedium.bump))
          .padding(Styles.sizeMedium)

        }  // END zstack
        .animation(Styles.animationQuickNSmooth, value: maxHeight)
      }  // END has any state

    }  // END main group
    .task(id: store.searchString) {
      let newResults = await store.fetchResults()
      store.searchState = newResults
    }
    .task(id: isPresented) {
      print("Changed search presentation state. `isSearchPresented` now: \(isPresented)")
      if !isPresented {
        store.searchState = nil
      } else {
        store.searchState = .noSearchString
      }
    }
  }
}
extension QuickSearchView {

  private var maxHeight: CGFloat {
    switch store.searchState {
      case .searching(.noResults), .noSearchString, .none: 120
      default: isPreview ? 520 : 320
    }
  }

  private var isPresented: Bool { store.isSearchPresented }
}

#if DEBUG
@available(macOS 15, iOS 18, *)
#Preview(traits: .size(.normal)) {

  @Previewable @State var store = ExampleSearchHandler()

  ZStack(alignment: .top) {
    CustomStylesOverview()

    QuickSearchView(
      store: $store,
      axis: .vertical,
    ) { itemID in
      print("Tapped \(itemID)")
    }
  }
  .searchable(
    text: $store.searchString,
    isPresented: $store.isSearchPresented,
    placement: .toolbar,
    prompt: Text("Search Tools")
  )
  .onAppear {
    store.searchState = .noSearchString
    store.isSearchPresented = true
    store.searchString = "im"
  }

}
#endif
