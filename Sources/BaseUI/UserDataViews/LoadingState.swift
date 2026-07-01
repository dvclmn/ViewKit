//
//  LoadingState.swift
//  ViewKit
//
//  Created by Dave Coleman on 6/2/2026.
//

import CoreTools
import SwiftUI
import ViewKitCore
import ViewTools

public struct UserDataView<Store: UserDataHandler, Content: View>: View {
  @Environment(\.undoManager) private var undoManager

  @Bindable var store: Store
  let persistUserData: (Store.Value) -> Void
  let content: () -> Content

  public init(
    store: Store,
    persistUserData: @escaping (Store.Value) -> Void,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.store = store
    self.persistUserData = persistUserData
    self.content = content
  }

  @available(*, deprecated, renamed: "init(store:persistUserData:content:)")
  public init(
    store: Store,
    didUpdatUserData: @escaping (Store.Value) -> Void,
    @ViewBuilder content: @escaping () -> Content,
  ) {
    self.init(
      store: store,
      persistUserData: didUpdatUserData,
      content: content,
    )
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
        content()
          .task(id: store.userDataIfPresent) {

            // Usually looks like this:
            // ```
            // persistUserData: { data in
            //   store.$storage.withLock { $0 = data }
            // }
            // ```
            store.userDataDidChange(updateStorage: persistUserData)
          }
          .task(id: undoManager) {
            store.undoManager = undoManager
          }
          .environment(\.isLoading, false)
          .environment(store)
    }
  }
}

@available(*, deprecated, renamed: "UserDataView")
public typealias DataStoreView<Store, Content> = UserDataView<Store, Content>
where Store: UserDataHandler, Content: View
