//
//  LoadingState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools
import SwiftUI

public struct DataStoreView<Store: UserDataHandler, Content: View>: View {
  @Environment(\.undoManager) private var undoManager

  @Bindable var store: Store
  let didUpdatUserData: (Store.Value) -> Void
  let content: () -> Content
  //  let content: (Store.Value) -> Content

  public init(
    store: Store,
    didUpdatUserData: @escaping (Store.Value) -> Void,
    //    @ViewBuilder content: @escaping (Store.Value) -> Content
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.store = store
    self.didUpdatUserData = didUpdatUserData
    self.content = content
  }

  public var body: some View {
    switch store.dataState {
      case .idle, .loading:
        ProgressView("Loading…")
          .task {
            /// Only set status if not already set to Ready
            guard !store.isReady else { return }
            store.setReady(store.storage)
          }
          .environment(\.isLoading, true)

      case .failed(let error):
        StateView("Error loading data", message: error.localizedDescription)
          .environment(\.isLoading, false)

      case .ready:
        //      case .ready(let data):
        content()
          //        content(data)
          .task(id: store.userDataIfPresent) {

            /// Usually looks like this:
            /// ```
            /// didUpdatUserData: { data in
            ///   store.$storage.withLock { $0 = data }
            /// }
            /// ```
            store.userDataDidChange(updateStorage: didUpdatUserData)
          }
          .task(id: undoManager) {
            store.undoManager = undoManager
          }
          .environment(store)
          .environment(\.isLoading, false)
    }
  }
}
